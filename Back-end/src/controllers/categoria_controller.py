from fastapi import APIRouter

from schemas.categoria import CategoriaCadastro, CategoriaEditar
from src.repositories import categoria_repository
from src.repositories.categoria_repository import cadastrar

router = APIRouter()

@router.get("/categorias")
def listar_categorias():
    return categoria_repository.consultar_todos()

@router.post("/categorias")
def cadastrar_categoria(categoria: CategoriaCadastro):
    categoria_criada = categoria_repository.cadastrar(categoria)
    return categoria_criada

@router.delete("/categorias/[id]")
def apagar(id: int):
    categoria_repository.apagar(id)

@router.put("/categorias/{id}")
def editar(id: int, categoria: CategoriaEditar):
    categoria_repository.editar(id)