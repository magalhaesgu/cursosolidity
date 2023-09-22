/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Gustavo Magalhaes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/

pragma solidity 0.8.19;

import "https://github.com/jeffprestes/cursosolidity/blob/master/bradesco_token_aberto.sol";

// Contrato: 0xc589D1Eb9d5fA38c57ab32E9fc3d3893c64B7E81

contract ExercicioTccGustavo{

    Cliente private cliente;
    ExercicioToken private exercicioToken;

    struct Cliente {
        string nome;
        string sobreNome;
        string agencia;
        string conta;
        address payable endereco; 
    }

    constructor(string memory _nome, string memory _sobreNome, string memory _agencia, string memory _conta) {
        
        //Endereco do token informado na descricao do exercicio
        address enderecoToken = 0x89A2E711b2246B586E51f579676BE2381441A0d0;

        cliente = Cliente(_nome, _sobreNome, _agencia, _conta, payable(address(msg.sender)));
        exercicioToken = ExercicioToken(enderecoToken);

        //Requisito do contrato ter saldo mínimo de 100,00
        gerarTokenParaEuCliente(10000); 
    }

    function meuSaldo() public view returns(uint256) {
        return exercicioToken.balanceOf(address(this));
    }

    function gerarTokenParaEuCliente(uint256 _valor) public returns (bool){
        return exercicioToken.mint(address(this), _valor);
    }


    /*
    ***** Exercicios Plus ******
    */

    /* parte A)*/
    function transferirTokenParaTerceiro(address _enderecoDestino, uint256 _valor) public returns (bool){
        require(meuSaldo() - _valor >= 10000, "O saldo deve ser maior ou igual a 100,00");
        return exercicioToken.transferFrom(msg.sender, _enderecoDestino, _valor);
    }

    /* parte B)*/
    function retornarSaldoCriptomoedaNativo() public view returns(uint256) {
        return address(this).balance;
    }

    /* parte C)*/
    function transferirCriptomoedaNativo(address _enderecoDestino, uint256 _valor) public {
        payable(_enderecoDestino).transfer(_valor);
    }

}
