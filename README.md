# kokotoba-infra

Kokotoba 共通で使うインフラ定義を置くディレクトリです。

## いま入っているもの

- PostgreSQL 16
- pgvector 拡張
- Flyway によるスキーママイグレーション
- 永続化ボリューム

## 起動

```sh
cd kokotoba-infra
cp .env.example .env
bash ./up.sh
```

`up.sh` は PostgreSQL の起動後に未適用のマイグレーションを自動適用します。
スキーマ定義は `postgres/migrations` にだけ置き、サービス側ではテーブルを作成しません。

マイグレーションだけを適用する場合:

```sh
docker compose run --rm migrate
```

変更時は適用済みファイルを編集せず、`V2__説明.sql` のような連番ファイルを追加してください。

## 接続情報

- Host: `localhost`
- Port: `5432`
- Database: `kokotoba`
- User: `kokotoba`

パスワードは `.env` の `POSTGRES_PASSWORD` で変更できます。

各サービスでは次の接続文字列を指定します。

```sh
DATABASE_URL=postgresql://kokotoba:kokotoba_dev_password@localhost:5432/kokotoba
```

## 停止

```sh
bash ./down.sh
```
