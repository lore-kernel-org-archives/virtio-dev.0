Return-Path: <virtio-dev-return-14241-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35932C3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 11:10:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A2FB81FF73
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 11:10:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90CEE9866FE
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 11:10:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8496D9863E1; Mon, 15 Jan 2024 11:10:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74BF298636D;
	Mon, 15 Jan 2024 11:10:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+pv7i13dJjdO/eblMPy7xmIz1A8tzTUMDurkLQx40TZlyk0vVDI8HkK5xjRddgR5K3yR9pCM5XS1UTuMq/y0g/bdZAlhxdXIPFdr3Ttzy8n8rIsW+hTfDl+LkMkmNI/hkVEgqnqB/rvnWIGqi0fifHQDF4DgYSyq4y8iGJeMwCL4gC9s2aYJcs/YAhUlHf0VcwAGPb6OyYQSl7mvLie0rFtHoPYwWiwiJDGT1wOUfaJj34XyPOJQ3SrsKuji+ms9zYB1ltDTnHMKZhhMF/ivFcZvomcjMW4zwqEj7Tsv5R3gaUzNQxnDafWI8ePl07PLRJNdXdTL7npGN5IvnHYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWOM3ACHX7BxABOk20ztWu4sIHXGhlyFsZE/HkU7weA=;
 b=c4biLFZGUGlPHeBNQL3qPFSXZMxiB4ndT63ckBNR5pmRFj2FabFlTtldyy3Jv/ppl5RnQBOU279pGrAC/wWxNZ6mYY+TyMluegfq70oV0K+CXvm1QqZ1ZeMi5/5cHWNSrL6t71VHjYZVl+DCt9lrZp7JVB7XBxInEEyDJ7R7Nh6fHWldq0/s0p8A1/JVt7mYx4jFHrqgOsapaFHOiIHordIE/pU+jOV6Ku2geRkdgPaMidf/tluoC3wRZehWGchpIzI8gXdUEpqJFn2+xXHbq11e6CJSPCg7fxcPBDhokLYc+MwblNNO333x20G+aFETx7OKSR7psWOCKlqS9iAEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
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
	"Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQgAIBBQCAAAGaAIABFX6AgHlRKACAAAN/0IAACNEAgAAEgaCAAAwWgIAABN1AgASS9ACAAADIQIAAA3aAgAABUvCAAAfBgIAACCRggAAFhACAAADCcIAAB8gAgAAAqUCAABIUAIAAAJPQgAAFBgCAAABBkA==
Date: Mon, 15 Jan 2024 11:10:31 +0000
Message-ID:
 <PH0PR12MB5481FFD5FEDFD63C75927878DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58497CDB1A3AE937CAF24BCFE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54816CC7AEE14209D3ECF795DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58496E8AA1278A8E3573CCB7E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481469DD511988B1A0D306CDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584944D5ECADD4566A8E066CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481FC877410A34DF11CFBFCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D9B54611E347DA492F0CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB5849D9B54611E347DA492F0CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB6892:EE_
x-ms-office365-filtering-correlation-id: 5e18f45b-6fdf-4c99-1d9c-08dc15ba96db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZOZZ9kKE8FnLfh8XeTU/kcyQQkFzYWNQBZDeSy1FUwVDH9WP44jpLTS6PZkiZd7pkUh4oGwDtIo9ClVq89sV9HgkRtfdk1XfYGvW2hGtAmtRT+b2cy6OI+eH7luwIR73zVYoJ7s0g7LQXPn6+eZcv9wu7cjAtJoPkHjg8KGNOYl69XN0KGH2iyJ+qyvkVivF5BdoFkk0yGA/Rb2diBN5fM5RyEN/TJx/C7ros/ZuAlAm6Kr1ds28u+5v/rekrjKQPamt5MLB2xMH0OxTVlhfHha2y2NZrgwOX4hVqGtz56N3g2JXhX4hKxVgVXtG+/tbb3ea7NEDnOVmuAld7Ui7WoMC259wdZCPtLsoTxBjzWp2zi+c6BBsGJrayJPwj0mxqevhImWpENAIGtQlJyzG+IToj3Pg78gePS99MMvbT3RjV/GXp4IVvq0RZgl81n8N80HfexTdHz+9UfmPaX/n99IhjVkbA+HPQ2ZY3AJ/6iQD6UNBrxXHzGuKnTCGlqzwgvnx5bDRcpFg1rzLxQ0B3qlJ5P4J/zYrTsJIZhRA1Zev1OH+hJ2fXaHXOexNYImzAH9wUOsluanMVCm4/m9JYde1lpijg/Oy7NW4g6dvfwz6xjcJaOfvryeHly8RUT6I
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(83380400001)(5660300002)(71200400001)(8676002)(8936002)(4326008)(2906002)(7416002)(55016003)(86362001)(122000001)(33656002)(26005)(7696005)(6506007)(55236004)(9686003)(53546011)(478600001)(66946007)(76116006)(316002)(66446008)(6916009)(66556008)(66899024)(66476007)(54906003)(64756008)(52536014)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkdGRWpOc1dJUUh2M3pFRk5Fbm9FbnoyVzhyVCtqUW9vMzU5b1VMTGJKTWg2?=
 =?utf-8?B?UEk3REhKcDhnLzFKUzJWd3A3YTQ5aUhBVk5Gcmk1Rm52VVlhWE9YT1dSTnRw?=
 =?utf-8?B?SWRyRUdRb1Bpd1hFTnpxak5pbXVpWEwydFozL1doellyRUVMVExROVp6eCsw?=
 =?utf-8?B?SnZMV2YyTE1wY3ZPeFFMSDNsamQxVENrOFpJc2hmcWt1MFFQb3BPaWFPcG5q?=
 =?utf-8?B?M1h0OFZTR0gzWVNlbXU3Nm9SMEhZSXIxNDkra1Z2cythZW9xN3prMXZ1VjRJ?=
 =?utf-8?B?VmVENkR2RzdMR0E2djVwaThpRmVwakVudHh3UDMxYk84djkwL3B6VlNXV0V6?=
 =?utf-8?B?YW5jVUhjSnp5c2NObitDNVNaa1JFQUNDNndnZlRabG1PRVZCaFJ6eXRDdEF6?=
 =?utf-8?B?dUhiVS93OTlIZ21ueFdpeUhtRE16VlplbTBkbDFpWFFvbzBucnhiL0dVODla?=
 =?utf-8?B?OFp3NU1sU0xpWWZYSG1lWWZwbkEzckQxNHluVWdsU1hmT3VTQWcreU1HdEsy?=
 =?utf-8?B?NXBadnRsanFSTUhvT0dqSS80WVVLZC9GN1dsL2pRMi9wM2hqTGc5ME9ycndh?=
 =?utf-8?B?a3czNjdZRGlMWURuMGg1VXk1YVFiZjdEcnAwZmJRSFU4Q1o2cGUzUEZCTURl?=
 =?utf-8?B?T3loa0o1ZTduN3dFY2Z5Rk5hQmtEQXNGbjVtVTZ2b0VKQThsb0grQTRQVlhG?=
 =?utf-8?B?V2FkU29GUWs1eDJCMk1hSHZGS0dHaTd5KzlFaFFnem9VaHRqbUU4eTUvWlVQ?=
 =?utf-8?B?TWdLeU1LR0srbWdTdHpIa2t5RFVLRHBvMGp3NHR2VDVET1FjMllYNjFIdTll?=
 =?utf-8?B?aG5vdmN4Y3g1ZmtjQlNlSmRaQVdDa3dHUkFxOTZUMSs3ZEExbnZ5WFMyckx2?=
 =?utf-8?B?cXlvUkNCSFJNZDFnY1BqMVpxRHgyMmRhcm92YXp2STZpRDdwRHJKTGt4bk1l?=
 =?utf-8?B?SUxxb2VzWi9PeTRlS2FUNmJVUVp3RUVnZkJPRUgzZjdaT2gwTFN4a3Z4Q0FI?=
 =?utf-8?B?RmhsTEZ1eDRmdGh1MnRaR2YzdnJFUFQ5bjAvNlREWWxkMXFOb1E5SGdBUXNm?=
 =?utf-8?B?NmFkUS8wY0lOaGtoZ012Mm1STzRzNlU2ZXJrT0k2Q1dJdmFLNU10NjVIQ3h6?=
 =?utf-8?B?SWlkT2d1Z1Jka3Y1UEpqakpZenErRHVsc1p5QlBmMG9ObGdqUXJuS3VxMHpG?=
 =?utf-8?B?cFphVmJsRHpiZkJab3BDTWR4ODV4UlF6SWNWNUFleFhIZ24wbGIwSVcxUUtE?=
 =?utf-8?B?VndIaERncjFEUHMxNnNjWU5BbHVaSHZsZGs1cmx4dXB4NmdqUXVQbUV5d2ZQ?=
 =?utf-8?B?OGdqQzM3RmphODNuQTI5K2xWeUJPcElsb3ByQWI2d2lUMkJ2eG1vUnhnOSt5?=
 =?utf-8?B?VlNMQnZ0V2VkOElyQVlBYzNlb3pCTk5uSnVLaGFYNXB4NUNaRmltOG41cSsv?=
 =?utf-8?B?TW8vZ04rNm1hR3M2YXM4YnRBU2FJU1F4Z09YbExieTlkQk5KYTBBOGg4Njcy?=
 =?utf-8?B?bFAwTU9KckZONWg4TGdwejdZY045UEE0L1hyQkNhdlRudkE0Uitya1RwbmFk?=
 =?utf-8?B?SmMrSElSUHA5Mml4VU82WFR0VVp6L2lhTDVhWFRyTFY3M1AzVE9NZHNSblRt?=
 =?utf-8?B?STdFQ2ZlbmdTOVVCREJieXVhTFlrQy9rQmJSbmduVko5dkw2SHBaTzI5WE94?=
 =?utf-8?B?L2RRMEIra3FvRlhjYnNmSWtORXJid1RzaTNXQmlFR2x2cXJHeDVJc0NMVU1S?=
 =?utf-8?B?UFFwUnE5bU8zS0JxSmRSUmtta1hPT3B5UE9DbFpLamluU2lpNlVSQVNyQXkv?=
 =?utf-8?B?azJIalFKMXo4ei95d1FrM0hTK05CVC92UjducldvQzlDQmRWK1hRTEZCSGN6?=
 =?utf-8?B?TWFFK2F2Mld6VmRPK2VCNmFQYnhJMWdaRjNpWXFQbVA0d1YwT3o3cFN3VXFW?=
 =?utf-8?B?QUd4NzlUYWpvQnBYblRlV1Y0K3FPRDRGU01zNitLMkZGNE41WGFhTlBQbDY0?=
 =?utf-8?B?SzBNSDhqNDMrNDBOeGZJdlhYdzBtQ1Z4cjZ0NzdWdFgyd01IamdEOU5HbTZZ?=
 =?utf-8?B?ekpabVAvK29SNkRLUTZOTmQ0Z1BwdFBwR3pwMXpKRlFiUlZKZFg4UExLN2FU?=
 =?utf-8?Q?R1SQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e18f45b-6fdf-4c99-1d9c-08dc15ba96db
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 11:10:31.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72nfdvyZLI8YD9DlJX+yUhI1+/TIjnQ33JWiq48ZHhayQ6yZoj+YGf46Fw5zS8TeSDVYEFp5sk0UMS59AiPuCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDQ6MzcgUE0NCj4gDQo+IE9uIDIwMjQvMS8xNSAxODo1Miwg
UGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFu
LkNoZW5AYW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDQ6MTcg
UE0NCj4gPj4NCj4gPj4gT24gMjAyNC8xLzE1IDE3OjQ2LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+
ID4+Pg0KPiA+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4g
Pj4+PiBTZW50OiBNb25kYXksIEphbnVhcnkgMTUsIDIwMjQgMzoxMCBQTQ0KPiA+Pj4NCj4gPj4+
Pj4gRGlzcGxheSByZXNvdXJjZXMgc2hvdWxkIGJlIG9ubHkgcmVzdG9yZWQgd2hlbiBmb2xsb3dp
bmcNCj4gPj4+Pj4gY29uZGl0aW9ucyBhcmUNCj4gPj4+PiBtZXQuDQo+ID4+Pj4+IDEuIFBDSSBQ
TSBjYXAgaXMgcmVwb3J0ZWQuDQo+ID4+Pj4+IDIuIFBDSSBQTSBjYXAgaGFzIG5vbl9zb2Z0X3Jl
c2V0PTEgMy4gdmlydGlvIGd1ZXN0IGRyaXZlciBkbyBub3QNCj4gPj4+Pj4gcGVyZm9ybSByZXNl
dCB3aGVuIHRyYW5zcG9ydCBvZmZlcnMgYSByZXN0b3JlDQo+ID4+Pj4gY2FwYWJpbGl0eSB1c2lu
ZyAjMSBhbmQgIzIuDQo+ID4+Pj4+DQo+ID4+Pj4+IERvIHlvdSBhZ3JlZT8gWWVzPw0KPiA+Pj4+
IFllcywgSSB0aGluayB0aGlzIHByb2JsZW0gKGRpc3BsYXkgcmVzb3VyY2VzIGFyZSBkZXN0cm95
ZWQgZHVyaW5nDQo+ID4+Pj4gUzMpIGNhbiBiZSBzb3J0ZWQgdG8gdHdvIHNpdHVhdGlvbnM6DQo+
ID4+Pj4gRmlyc3QgaXMgd2hhdCB5b3Ugc2FpZCBhYm92ZSwgaW4gdGhpcyBzaXR1YXRpb24sIHRo
ZSBkZXZpY2VzX3Jlc2V0DQo+ID4+Pj4gb2YgcWVtdSBpcyB1bnJlYXNvbmFibGUsIGlmIGEgZGV2
aWNlIGhhcyBQTSBjYXAgYW5kDQo+ID4+Pj4gbm9uX3NvZnRfcmVzZXQ9MSwgcWVtdSBzaG91bGQg
bm90IGRvIHJlc2V0dGluZy4NCj4gPj4+DQo+ID4+Pj4gU2Vjb25kIGlzIHdpdGhvdXQgIzEgb3Ig
IzIsIHRoZSByZXNldCBiZWhhdmlvciBpcyBmaW5lLiBNeSBwYXRjaCBpcw0KPiA+Pj4+IHRvIGZp
eCB0aGlzIHNpdHVhdGlvbiwgdGhhdCBzZW5kaW5nIGEgbmV3IHZpcnRpby1ncHUgY29tbWFuZCB0
bw0KPiA+Pj4+IG5vdGlmeSBxZW11IHRvIHByZXZlbnQgZGVzdHJveWluZyBkaXNwbGF5IHJlc291
cmNlcyBkdXJpbmcgUzMuDQo+ID4+Pg0KPiA+Pj4gSSBzdGlsbCBoYXZlIGhhcmQgdGltZSBmb2xs
b3dpbmcgIk15IHBhdGNoIGlzIHRvIGZpeCB0aGlzIHNpdHVhdGlvbi4uLiIuDQo+ID4+Pg0KPiA+
Pj4gV2hlbiAjMSBhbmQgIzIgaXMgbm90IGRvbmUsIHRoZXJlIGlzIG5vdGhpbmcgdG8gcmVzdG9y
ZS4NCj4gPj4+IERyaXZlciBzaG91bGQgbm90IHNlbmQgc29tZSBuZXcgdmlydGlvIHNwZWNpZmlj
IGNvbW1hbmQgd2hlbiAjMSBhbmQNCj4gPj4+ICMyIGlzDQo+ID4+IG5vdCB0aGVyZS4NCj4gPj4+
IEluc3RlYWQsIGlmIHRoZSBkZXZpY2Ugd2FudHMgdG8gcmVzdG9yZSB0aGUgY29udGV4dCwgYWxs
ICMxLCAjMiBhbmQNCj4gPj4+ICMzIHNob3VsZA0KPiA+PiBiZSBkb25lIHRvIGltcGxlbWVudCB0
aGUgcmVzdG9yZSBmdW5jdGlvbmFsaXR5Lg0KPiA+PiBXaGVuICMxIGFuZCAjMiBpcyBkb25lLiBU
aGUgImRldmljZSByZXNldCBiZWhhdmlvciIgc2hvdWxkIG5vdA0KPiA+PiBoYXBwZW4uIEFuZCB0
aGVuIHRoZSBkaXNwbGF5IHJlc291cmNlcyBhcmUgbm90IGRlc3Ryb3llZC4NCj4gPj4gSSBkaWRu
4oCZdCBzYXkgc2VuZCBjb21tYW5kIHRvIHJlc3RvcmUgY29udGV4dC4NCj4gPg0KPiA+PiBJIG1l
YW4gd2hlbiAjMSBhbmQgIzIgaXMgbm90IGRvbmUuIERyaXZlciBhbmQgcWVtdSBib3RoIHJlc2V0
IGRldmljZXMNCj4gPj4gd2hlbiByZXN1bWluZywgYXQgdGhhdCB0aW1lLA0KPiA+IEFib3ZlIGJl
aGF2aW9yIGlzIGFzIHBlciB0aGUgc3BlYyBndWlkZWxpbmVzLiBIZW5jZSBpdCBpcyBmaW5lLg0K
PiA+DQo+ID4+IHdlIG5lZWQgYSBtZXRob2QgdG8gcHJldmVudCB0aGUgZGlzcGxheSByZXNvdXJj
ZXMgZnJvbSBkZXN0cm95aW5nLg0KPiA+IEkgZGlzYWdyZWUgdG8gYWJvdmUgYXMgaXQgaXMgbm90
IGFzIHBlciB0aGUgc3BlYyBndWlkZWxpbmVzLg0KPiA+IEp1c3QgZm9sbG93ICMxLCAjMiBhbmQg
IzMgdG8gbm90IGRlc3Ryb3kgdGhlIGRpc3BsYXkgcmVzb3VyY2UgZGVzdHJveWluZy4NCj4gSSBh
Z3JlZSB0aGF0IGZvbGxvdyAjMSwgIzIgYW5kICMzIHdpbGwgbm90IGRlc3Ryb3kgZGlzcGxheSBy
ZXNvdXJjZS4NCj4gU28gdGhlIHF1ZXN0aW9uIGdvZXMgYmFjazogSWYgdGhlcmUgaXMgbm8gIzIg
YW5kIHlvdSBzYXkgdGhhdCB0aGUgcmVzZXQNCj4gYmVoYXZpb3IgY29tcGxpZXMgd2l0aCB0aGUg
c3BlYyBndWlkZWxpbmVzLCBob3cgY2FuIEkgbWFrZSB0aGUgdmlydGlvIGdwdQ0KPiB3b3JrIHBy
b3Blcmx5IHdpdGggZGlzcGxheSByZXNvdXJjZXMgZGVzdHJveWVkPw0KSW1wbGVtZW50ICMyLiA6
KQ0KDQo+IFdoYXQgbXkgcGF0Y2ggZG8gaXMgbm90IHRvIHByZXZlbnQgcmVzZXR0aW5nLCBpcyB0
byBwcmV2ZW50IGRlc3Ryb3lpbmcNCj4gcmVzb3VyY2VzIGR1cmluZyByZXNldHRpbmcuIEdlcmQg
SG9mZm1hbm4gaGFzIGFncmVlZCB0byB0aGlzIHBvaW50IGluIG15DQo+IHFlbXUgcGF0Y2ggcmV2
aWV3aW5nLg0KPiBFdmVuIGlmIEkgdXNlIFBNIGNhcCwgSSBzdGlsbCBuZWVkIHRvIHByZXZlbnQg
ZGVzdHJveWluZyByZXNvdXJjZXMgZHVyaW5nDQo+IHJlc2V0dGluZy4NCkRvIHlvdSBtZWFuIHdo
ZW4gdmlydGlvIGRldmljZSBpcyByZXNldCwgeW91IHdhbnQgdG8gcHJldmVudD8NCklmIHNvLCB0
aGF0IGlzIHlldCBhZGRpdGlvbmFsIHZpcnRpbyBzcGVjIGhhY2sgdGhhdCBtdXN0IGJlIGF2b2lk
ZWQgYXMgcmVzZXQgZmxvdyBzaG91bGQgYmUgb25lLg0KUGxlYXNlIGRvICMzIHRvIGF2b2lkIHJl
c2V0dGluZyB0aGUgZGV2aWNlLg0K

