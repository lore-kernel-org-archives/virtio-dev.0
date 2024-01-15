Return-Path: <virtio-dev-return-14238-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45E6C4707C
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 10:47:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 06F52750AB
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 10:47:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0032D986526
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 10:47:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E53B49861D0; Mon, 15 Jan 2024 10:47:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2F02986367;
	Mon, 15 Jan 2024 10:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBNtvkGIRCr6t2PvKH8H0wwpksECwKmG3f2dnGA937FREGOdc26PFWo9VIcz0R3REb0RmPKYA6JS1e8Qq2tyw7EJAw11lTdZAA2FK2jF8OW1SoLt5EV1pTMqa68wJmoBMOGxc1pDEAxwM2iE0aKi2izYC+eb9AMu6/g1oX3IdxWquCyuVMuZLXC6j8cylgq733WndGt7dYR7aM+r9GgbcUp3rk6wcBi/BqD4VypMlnU3uo7zdhtuWJtE/hiOnCKZc4DqnTs03TbQnnbJcinL4+orxWGgM52e7ee6oqezfb67OO2M3/ZUvHr2BDpFRhLQsWYpzRsdWUbrBM91Py4Lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IslKPnWOg2pHMlQdGBQj1xgcKM/LoKm/AJC4Kn6o+/M=;
 b=hLI/s298sRStnihip5/YBeX2cMOOyT7U1BxUpba5ezvikWJjEyiBaNsSa9pq/WNi+mZV12JcVgSOE2TIfifiR0mEaBQH89I2X54i5qRdY9i0j0N5nzXmDxbtCIJy9ih9x57X6Mdnpijtc35zTcHWDTHpY+I3ZWYb8g9Ym6FxShs4MaWtRXe54uw6ivSY/H9+IzQo5wEK2hoGrf6LMNNVfW/a8dyXb1cfiggZJ43l4w8dBezTx13gEbI69nbAbv2FUZb5Hxe1YIYDH/EAfgxg5a4iZdLvFlOLC55iwoKc/DT3+3LH0HY3srzWbZetPSa1ThU5bu0jp83EbvqIwypUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4D//31GAAAQ5xwAABBKiAAAD6fOAAAuOxQAAEuTxoAApzqngAE9jPcAAorzqoAFA43jgA==
Date: Mon, 15 Jan 2024 10:47:16 +0000
Message-ID:
 <BL1PR12MB584944D5ECADD4566A8E066CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58497CDB1A3AE937CAF24BCFE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54816CC7AEE14209D3ECF795DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58496E8AA1278A8E3573CCB7E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481469DD511988B1A0D306CDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481469DD511988B1A0D306CDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MN0PR12MB5764.namprd12.prod.outlook.com
 (15.20.7181.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM6PR12MB4974:EE_
x-ms-office365-filtering-correlation-id: 2ce7c899-1ffc-408e-7c28-08dc15b75734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2TXR58p4X7Bv1S1c5wOXm1prVfhYuZjGu1BOF8DxVYEeY186poFlp0+CF3TiQ9q6D3ODTcmxdWJ3MJ6gvfJg/E7z4QhXRn8bBsbC2mexWsA/p22M7npmx94SlM4k3J2MeX53iVpsDRgF8zZb4VUe/GaLa3Rxje8ObardL8quva3C4fsV1kSeLXI4nsUnQNVguTa1D1p8kzsKvylt13SWfr7OXtmdYplx19TNU79fygjky3uF3Kyd7aGrOtavLnkLM7stuZzfWUx2qY3D/F8Pj4vilVTCGClI32X5aDtVBq5nYVomewjzt4GNKrL45HYUAjxz3C5HAXImADYYHwy1stYl4Hn+8Bp+u0DPnCWyXTbxr/JuhNt17G2uquxyS/D1G9S8UfliAQ2XJCY6VkvgV2xTw0mLZHWhfAsaFjgM8g87x2n8wP8kPp7IdIiXDybb45WYz3ES7dnIV3fI6Vz0IMGV5NQ6ILBr05ROECEud40TlJFIjUyxgbyeMS35ItP85sIf2VM7oHt1KR9fP4j+Y8vm16uESKsIfuo+OLjSa8hxhgjlgvjujUbDgftN2R43WWJTHLVIPVYk2Fca5z+QoJ+43zPMSBybx18ECCqasrQ+Hwfdltmi1GAlYD4I4gm/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66946007)(66476007)(76116006)(66446008)(38100700002)(64756008)(55016003)(316002)(54906003)(6916009)(53546011)(9686003)(6506007)(7696005)(8676002)(478600001)(41300700001)(8936002)(38070700009)(4326008)(83380400001)(26005)(52536014)(71200400001)(33656002)(2906002)(66899024)(5660300002)(7416002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDFacURYSmNsd0J4SDBpeTd2MThsU3JpRGJzbFRHNks0bHo0L09MUkk2SEdD?=
 =?utf-8?B?K2NWYkhNZTI2QWozS2prMUFYVjh5bkRLWGNmSTlOYngzaWFpVFdqbEtNTUVX?=
 =?utf-8?B?dHY2N2RiamtUZUY5R1llRCtRMDh0d3A1QjNEQjJvUU5qcmp6TUdiTWpDekVL?=
 =?utf-8?B?R0E0bHR6MGUzcjkwSDBCaitBMFowbFA0cnZiTXhkZkZPYmxTWmF3d2dQSlkx?=
 =?utf-8?B?Rm9GTXlzSFVxZEg4Z3JEMDRNS0tJRHlaZ1RUaWFReWxiU3V5dFlSTmFwKzBq?=
 =?utf-8?B?UXlOL1lDT2Q1T1E0ZVFwd0huZXFqcllrckt0bzdvb1R5ejExb3pKUFpFbzEr?=
 =?utf-8?B?V1NEemZJT1daOGx3LzA1NGNxSTlVTDViZXZhVG5udG1rTUhDR2pJRk81ZmVO?=
 =?utf-8?B?THN3d09kdkVoeTJqZHAycFRoSk10RVhkOWdCQUxXQW52Q252Tk8vTUpIc1gr?=
 =?utf-8?B?eENjaGs0YlQzeGZkZ24rYzU3WGF0akFablZlRCtMVnFJWFlkcnlLOWFSWjJw?=
 =?utf-8?B?NHZrcTBUaW9jeHRqTVAzLzJLdlR1dW1xTzhmVVYxY2RaeFNvVS80VjJBVllh?=
 =?utf-8?B?UFo2Slg2NTlrd1dBWDRkY1U2TGFNWFBQYXk3U2lpSzBtbHBrOVJMaUl4ZVY4?=
 =?utf-8?B?OFZqdVhKNkxvQ2h2bVpHWlV3L0d1Mi9BZ3JuMGFORnNnbjJDVzEvdHpLV21H?=
 =?utf-8?B?dm9ZMDJEblgvaVAzS3ZlY1dHUWtWS1A5d21ZRW1WeStETndhb3NuR0t4bmVP?=
 =?utf-8?B?dkxUMFNmZHpDczNsc1hYODRUN0hvZ0hzclc1M2dSUElFZlJPbnQvWHVLZTht?=
 =?utf-8?B?UjlubGw0TkpLNkpOWS9iREtqRGc3ZWFqUG1rOVZVUzR4VEIxbWp3eGNCYmhH?=
 =?utf-8?B?TTZneENVQW1neEZNbFYrdHVZZG9hTG1Vb0hBcHNlRmJlOTV6S2tUdG1XU0pj?=
 =?utf-8?B?LzdsbFNjdmpEK29OdVpVV1pyZk0xdFBCelFISjdPa1ZDczlrVlBkWUU3a1Vu?=
 =?utf-8?B?N0d0OW94YWluYzUxRXc2UjdwMFozVEE0ek1Ra1YzdkIxN3U4bDZPcTNEaVZJ?=
 =?utf-8?B?R0R6QmRHSXVwN2ZtZEJMdXNHZzBiQ2FkdGFneFRPYXhKbG94SW5HUXhTSHgz?=
 =?utf-8?B?ZE5vMmJ1U05nN24rQkpkaUdkdUlzSGJDcktKNEs3NEd3MzFHeWhwTDRHTDhX?=
 =?utf-8?B?RzhxS0VOdlIvMytHZVBkWHh0VzJhcFRwbHZvSjJBRHZpMjlhK0FCMVQ3bHFa?=
 =?utf-8?B?UzRabTRNd05kNjMyaFQyYlNCSUVDcGxEUkx4aVYraGM0d0F3aHQ5SWhtOWdS?=
 =?utf-8?B?RWVLS3VmMDlOcVpoUllvdzJmazYvRDdjMnZDbzJpN0ZLQ3VzVmJnTWRINk4x?=
 =?utf-8?B?TEF6aWswYW00VVArTkxNNkVvTytMTHZrT0YycHBJNjNrT3ZhMFVqcGVJVGZB?=
 =?utf-8?B?NlcyK1lsWEVmb0piVXBzUGw1b2krOFo0WExjTnVnTEE0a2F1OXZCV2pZUnVB?=
 =?utf-8?B?RFpFdUNtNXdEZFZ0bHVxVFIyRlcva1pEdzBmSldTR0lLeDQvQmhMVXdNaURw?=
 =?utf-8?B?WmxjVVdnWFUzRmdybExObFBwNkl4U29zemxqdmpNRTE2OCs5Z245QWJxaXdQ?=
 =?utf-8?B?TitWYUx2RlFRdURaRG83SlZoeEtYOGc4K1N6M0NzUm9UWjY2MUxQSXpXUmdK?=
 =?utf-8?B?WUVOeWEwUzhweklFaTlQN1MyOUdrRTVGZEFYci9FZG9HZjFFVVZrVmNKTWk3?=
 =?utf-8?B?RmYzZTkweTZZVjVXOGQ2UmppSXBxOHlmTXhnQnZtQmZ0YkVjYzh5eWVNdDJT?=
 =?utf-8?B?bFpsQUF4azNqdG93eFNWOU90dHduYUFaWmd1RXpYWGNkb2RwODViZkVsMzg2?=
 =?utf-8?B?TFNEc001M3VHZWVwYjBmRlhzZFp6M0dSQlE1ZUVWR3dVZ0hJQzBpV2puNzho?=
 =?utf-8?B?cTZIejJNVFRTZTBCWG1zMGFHdmNSYjRlR1R3aTQ3Sk1VbTUxd0l2QTZiQm5n?=
 =?utf-8?B?anZhMUhCWnlGYWNyUHlwd1lQaDJYeUR0RnFkejRyZnR1aUZvSURsT1hEZDE2?=
 =?utf-8?B?NjRkcm82N0c2UWIrdHprNzk2VEhlK01IZlJYRWpnQS9TL09XMnc3ZFdyU216?=
 =?utf-8?Q?ct6I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2D51255D679974B999AF1C2839E3F48@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce7c899-1ffc-408e-7c28-08dc15b75734
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 10:47:16.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmjHS6fEjPouFlMb73voTFyj2c4APhMJVp80Z6LBbqQ9AjhDb0ApnEqNI6GZqJuvreEbTICfPLUb68OhLgSrpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDE3OjQ2LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJvbTogQ2hl
biwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDE1LCAyMDI0IDM6MTAgUE0NCj4gDQo+Pj4gRGlzcGxheSByZXNvdXJjZXMgc2hvdWxkIGJlIG9u
bHkgcmVzdG9yZWQgd2hlbiBmb2xsb3dpbmcgY29uZGl0aW9ucyBhcmUNCj4+IG1ldC4NCj4+PiAx
LiBQQ0kgUE0gY2FwIGlzIHJlcG9ydGVkLg0KPj4+IDIuIFBDSSBQTSBjYXAgaGFzIG5vbl9zb2Z0
X3Jlc2V0PTENCj4+PiAzLiB2aXJ0aW8gZ3Vlc3QgZHJpdmVyIGRvIG5vdCBwZXJmb3JtIHJlc2V0
IHdoZW4gdHJhbnNwb3J0IG9mZmVycyBhIHJlc3RvcmUNCj4+IGNhcGFiaWxpdHkgdXNpbmcgIzEg
YW5kICMyLg0KPj4+DQo+Pj4gRG8geW91IGFncmVlPyBZZXM/DQo+PiBZZXMsIEkgdGhpbmsgdGhp
cyBwcm9ibGVtIChkaXNwbGF5IHJlc291cmNlcyBhcmUgZGVzdHJveWVkIGR1cmluZyBTMykgY2Fu
IGJlDQo+PiBzb3J0ZWQgdG8gdHdvIHNpdHVhdGlvbnM6DQo+PiBGaXJzdCBpcyB3aGF0IHlvdSBz
YWlkIGFib3ZlLCBpbiB0aGlzIHNpdHVhdGlvbiwgdGhlIGRldmljZXNfcmVzZXQgb2YgcWVtdSBp
cw0KPj4gdW5yZWFzb25hYmxlLCBpZiBhIGRldmljZSBoYXMgUE0gY2FwIGFuZCBub25fc29mdF9y
ZXNldD0xLCBxZW11IHNob3VsZCBub3QNCj4+IGRvIHJlc2V0dGluZy4NCj4gDQo+PiBTZWNvbmQg
aXMgd2l0aG91dCAjMSBvciAjMiwgdGhlIHJlc2V0IGJlaGF2aW9yIGlzIGZpbmUuIE15IHBhdGNo
IGlzIHRvIGZpeCB0aGlzDQo+PiBzaXR1YXRpb24sIHRoYXQgc2VuZGluZyBhIG5ldyB2aXJ0aW8t
Z3B1IGNvbW1hbmQgdG8gbm90aWZ5IHFlbXUgdG8gcHJldmVudA0KPj4gZGVzdHJveWluZyBkaXNw
bGF5IHJlc291cmNlcyBkdXJpbmcgUzMuDQo+IA0KPiBJIHN0aWxsIGhhdmUgaGFyZCB0aW1lIGZv
bGxvd2luZyAiTXkgcGF0Y2ggaXMgdG8gZml4IHRoaXMgc2l0dWF0aW9uLi4uIi4NCj4gDQo+IFdo
ZW4gIzEgYW5kICMyIGlzIG5vdCBkb25lLCB0aGVyZSBpcyBub3RoaW5nIHRvIHJlc3RvcmUuIA0K
PiBEcml2ZXIgc2hvdWxkIG5vdCBzZW5kIHNvbWUgbmV3IHZpcnRpbyBzcGVjaWZpYyBjb21tYW5k
IHdoZW4gIzEgYW5kICMyIGlzIG5vdCB0aGVyZS4NCj4gSW5zdGVhZCwgaWYgdGhlIGRldmljZSB3
YW50cyB0byByZXN0b3JlIHRoZSBjb250ZXh0LCBhbGwgIzEsICMyIGFuZCAjMyBzaG91bGQgYmUg
ZG9uZSB0byBpbXBsZW1lbnQgdGhlIHJlc3RvcmUgZnVuY3Rpb25hbGl0eS4NCldoZW4gIzEgYW5k
ICMyIGlzIGRvbmUuIFRoZSAiZGV2aWNlIHJlc2V0IGJlaGF2aW9yIiBzaG91bGQgbm90IGhhcHBl
bi4gQW5kIHRoZW4gdGhlIGRpc3BsYXkgcmVzb3VyY2VzIGFyZSBub3QgZGVzdHJveWVkLg0KSSBk
aWRu4oCZdCBzYXkgc2VuZCBjb21tYW5kIHRvIHJlc3RvcmUgY29udGV4dC4NCkkgbWVhbiB3aGVu
ICMxIGFuZCAjMiBpcyBub3QgZG9uZS4gRHJpdmVyIGFuZCBxZW11IGJvdGggcmVzZXQgZGV2aWNl
cyB3aGVuIHJlc3VtaW5nLCBhdCB0aGF0IHRpbWUsIHdlIG5lZWQgYSBtZXRob2QgdG8gcHJldmVu
dCB0aGUgZGlzcGxheSByZXNvdXJjZXMgZnJvbSBkZXN0cm95aW5nLg0KSSBkb24ndCBtZWFuIGFu
eXRoaW5nIGVsc2UsIEkganVzdCBmZWVsIGxpa2UgeW91IG1heSBub3QgaGF2ZSB1bmRlcnN0b29k
IHRoZSBpc3N1ZXMgSSBlbmNvdW50ZXJlZCBkdXJpbmcgdGhlIFMzIHByb2Nlc3MgYW5kIHRoZSBp
bXBsZW1lbnRhdGlvbiBsb2dpYyBvZiBteSBwYXRjaCBmcm9tIHRoZSBiZWdpbm5pbmcuDQpJbiBj
dXJyZW50IGtlcm5lbCBhbmQgcWVtdSBjb2Rlcywgd2hlbiB3ZSBkbyBTMyhzdXNwZW5kIGFuZCBy
ZXN1bWUpIGZvciBndWVzdCwgZHVyaW5nIHRoZSByZXN1bWluZywgcWVtdSBhbmQgZ3Vlc3QgZHJp
dmVyIHdpbGwgcmVzZXQgdGhlIHZpcnRpby1ncHUoYmVjYXVzZSAjMiBpcyBub3QgZG9uZSksIGJ1
dCBvbmNlIHRoZSByZXNldHRpbmcgaGFwcGVucywgdGhlIGRpc3BsYXkgcmVzb3VyY2VzIHdpbGwg
YmUgZGVzdHJveWVkIGFuZCB3ZSBjYW4ndCByZXN0b3JlLCBzbyB3ZSBtdXN0IGFkZCBhIG1ldGhv
ZCB0byBwcmV2ZW50IGRlc3Ryb3lpbmcgcmVzb3VyY2VzIGF0IHRoYXQgc2l0dWF0aW9uLiBXaGF0
IG15IHBhdGNoIGRvIGlzIHRvIGFkZCBhIG5ldyB2aXJ0aW8tZ3B1IGNvbW1hbmQgdG8gbm90aWZ5
IHFlbXUgdG8gY2hlY2sgaWYgdGhlIGRpc3BsYXkgcmVzb3VyY2VzIHNob3VsZCBiZSBkZXN0cm95
ZWQgZHVyaW5nIHJlc2V0dGluZy4NCg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIGlmIG9uZSB3YW50
cyB0byB1c2UgZGV2aWNlIGNvbnRleHQgcmVzdG9yZSBvbiBQTSBzdGF0ZSB0cmFuc2l0aW9uIGl0
IHNob3VsZCBkbyAjMSwgIzIgYW5kICMzLg0KPiAoYW5kIGF2b2lkIGludmVudGluZyBuZXcgaW5m
cmFzdHJ1Y3R1cmUgYmVjYXVzZSBQQ0kgUE0gaGFzIG5lY2Vzc2FyeSB0aGluZ3MpLg0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

