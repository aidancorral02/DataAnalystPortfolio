--Exploring The Data

select * from NashvilleHousingData;

------------------------------------------------------------------

--Standarize Date Format

select saledate, CONVERT(Date, SaleDate)
from NashvilleHousingData;

Update NashvilleHousingData
Set SaleDate = CONVERT(Date, SaleDate);


Alter Table NashvilleHousingData
Add SaleDateConverted Date;

Update NashvilleHousingData
Set SaleDateConverted = CONVERT(Date, SaleDate);

select *
from NashvilleHousingData;

-----------------------------------------------------------------------

-- Populate Property Address Data

select PropertyAddress
from NashvilleHousingData
--where PropertyAddress is Null;
order by ParcelID;


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousingData a
join NashvilleHousingData b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousingData a
JOIN NashvilleHousingData b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

-----------------------------------------------------------------------------

--Breaking out Address into Individual Columns (Address, City, State)

select PropertyAddress
from NashvilleHousingData
--where PropertyAddress is Null;
--order by ParcelID;

select Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
Substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(propertyaddress)) as Address
from NashvilleHousingData;


Alter Table NashvilleHousingData
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousingData
Set PropertySplitAddress = Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Alter Table NashvilleHousingData
Add PropertySplitCity nvarchar(255);

Update NashvilleHousingData
Set PropertySplitCIty = Substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(propertyaddress))

select * from NashvilleHousingData;





select OwnerAddress from NashvilleHousingData;

select 
PARSENAME(replace(owneraddress, ',', '.'), 3),
PARSENAME(replace(owneraddress, ',', '.'), 2),
PARSENAME(replace(owneraddress, ',', '.'), 1)
from NashvilleHousingData;


Alter Table NashvilleHousingData
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousingData
Set OwnerSplitAddress = PARSENAME(replace(owneraddress, ',', '.'), 3)

Alter Table NashvilleHousingData
Add OwnerSplitCity nvarchar(255);

Update NashvilleHousingData
Set OwnerSplitCity = PARSENAME(replace(owneraddress, ',', '.'), 2)

Alter Table NashvilleHousingData
Add OwnerSplitState nvarchar(255);

Update NashvilleHousingData
Set OwnerSplitState = PARSENAME(replace(owneraddress, ',', '.'), 1)


select * from NashvilleHousingData;


---------------------------------------------------------------------

--Change Y and N to Yes and No in "Solid as Vacant" field.


select distinct(SoldAsVacant), count(SoldAsVacant)
from NashvilleHousingData
group by SoldAsVacant
order by 2;


Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From NashvilleHousingData;

update NashvilleHousingData
Set SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END;



----------------------------------------------------------------

--Remove Duplicates


with RowNumCTE as(
select *, 
	ROW_NUMBER() Over (
	partition by ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				Order by 
					UniqueID
					) row_num

from NashvilleHousingData
--order by ParcelID
)
select * from RowNumCTE
where row_num > 1
order by PropertyAddress;


select *
from NashvilleHousingData;


------------------------------------------------------------

--Delete Unused Columns

select *
from NashvilleHousingData;

ALTER TABLE NashvilleHousingData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
