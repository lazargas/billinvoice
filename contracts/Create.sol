//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import '@openzeppelin/contracts/utils/Counters.sol';
import "hardhat/console.sol";

contract Create{
    
    using Counters for Counters.Counter;

    Counters.Counter public _billId;

     address public invoiceSender;
    //invoices 
    
    struct Invoice{
        uint256 billId;
        string buyerPan;
        string sellerPan;
        uint256 invoiceAmount;
        uint256 invoiceDate;
        string ipfs;
    }
    
    event invoiceCreate(
        uint256 indexed billId,
        string buyerPan,
        string sellerPan,
        uint256 invoiceAmount,
        uint256 invoiceDate,
        address _address,
        string ipfs
    );
    
    address[] public invoiceAddress;

    mapping(address=> Invoice) public invoices;

    //end of invoice data

    constructor(){
        invoiceSender = msg.sender;
    }

    //functions

    function setInvoice(address _address,string memory _buyerPan,string memory _sellerPan,uint256 _invoiceAmount,uint256 _invoiceDate,string memory _ipfs) public {
       require(invoiceSender==msg.sender,"Only Organiser can authorized candidate"
        );
        _billId.increment();

        uint256 idNumber = _billId.current();

        Invoice storage invoice = invoices[_address];
        
        invoice.buyerPan = _buyerPan;
        invoice.sellerPan = _sellerPan;
        invoice.invoiceAmount = _invoiceAmount;
        invoice.invoiceDate = _invoiceDate;
        invoice.ipfs = _ipfs;

        invoiceAddress.push(_address);

        emit invoiceCreate(idNumber, _buyerPan, _sellerPan, _invoiceAmount, _invoiceDate, _address, _ipfs);
    }

    function getInvoice() public view returns(address[] memory){
        return invoiceAddress;
    }

    function getInvoiceLength() public view returns (uint256){
        return invoiceAddress.length;
    }

    function getInvoiceData(address _address) public view returns (uint256,string memory,string memory,uint256,uint256,string memory){
        return (
          invoices[_address].billId,
          invoices[_address].buyerPan,
          invoices[_address].sellerPan,
          invoices[_address].invoiceAmount,
          invoices[_address].invoiceDate,
          invoices[_address].ipfs
        );
    }
}



