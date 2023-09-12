Return-Path: <virtio-dev-return-13702-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BFECA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:54:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E0BB13357F
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:54:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7A59986655
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:54:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AF01C986630; Tue, 12 Sep 2023 07:54:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 848D5986485;
	Tue, 12 Sep 2023 07:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQpwhjt/5qbcsEGRlSAJITyDqQ97zk+Zo9lM9hPQBl9j70faLSNYPSUt7T8ZjNif1lgKgxqoskK4dROs8ZEEZ6YdaRUN+YSZY9VXhT3iWqLVaKU0JUoFwz0S/HGWGGh71Pg1LeZf8jn6EcL/Cf2wntYsb1p05geAORbYCphYDACs+qq7hQDL8d+trAsDGH//a9fCRD7CjGeNzfGC53bL4m0a0pSDiBBXTzS9v2b7LZnDgim3Ms0xHNlaV7TlHWjIgI+4+NgEPG2+7yJMIU2wyA5LwcWKsJX/Ly9bEO2ia0bYP5clHLAzt8kIThtHtwdG/9HRCNw/+yCk+K988HKTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVsWP11zli2XVle0UX53zfPsTjSYdf72cVxh16x7xSI=;
 b=MBaDhA/zCDi4Bf1JnttYUms0p7Kc8mxJrfUGZwvByrMqrZyOCtZvSEMco683POo8r63K6jwk7IUMdpKPnu/1FrD2RlreNxccCR1NAIvnNeIj4fT14qGH7sfhGphm4RW5zmSWTRroOBja5ERDNcHU0JKcEWkoDJG/G//3aWTzibtjwvU/1AJvb0TW3PCfNrDGozl5PkxRbxMhhEFvD0enhNT+XofC5qDfm80MXddewQpmKbnhJQKfWCX+lPOm7Nks3f1bNUU4sxvFGpMKSf1mrXYYi06eqtaNHxqUr6otzk/yaV2k9oN/Lompx9gSjNObzNR4zAjMqMao0vuEJcvh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzA=
Date: Tue, 12 Sep 2023 07:53:55 +0000
Message-ID:
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
In-Reply-To: <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB7246:EE_
x-ms-office365-filtering-correlation-id: bfc0fa47-71a7-486b-5dd0-08dbb3656a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wqcNPm9ERntGdD1R3UGOTzguPMC/AiKZRy+gjknirYSaR1zG3KMEw912/U5CdaRbWZjREqGnp6fjtRrIIDlzZLjrqaCnbw6sAGA3SctR/+ea+Ubtvspmednu4On01QZyewznaaQ0JDeM4vs7aJzBTP5aqDNnVkLeyKj2cC1dgQml8Lr9GEycQsLlgq4z4aQf0hUzOzjscKfgYOWO92irgZQHGIcJJdYuw8dofeTrlJgm246v4d2+vCrVQr/hjy9fczvPlcAwnXsNXBXKqkhK4a6dr/nt1YmxhA38uzSCZw1T/LR6ctkBnodCAv30Sv+Is7TM0X+LIX7uenP1XhHdSDH58NUvexNfNIieH73sDL414ysQIwpRCYeTyCvu89e4qv9pCOCy1T3kVbmrlT9FVXKW1fcZPBtZOFEQCcQauHFY143TbG+jMcTCVBI/IbiehiS/q+7dJEfis6Rxh/6Z/flV2hIYePVP8QgcgDZO73l5/sHcB9SDP5iDfifh4eH966AxsyhqHV9ilLOhD0xSu6wpjpDQFTwZYbV++10KVO4AuLjNc4oNf8AR/pFkmL2se56F/IiCuR/TSLtILTs8FpWu8+N/iaNRQ9biRA+15kIi+4KgFdyKyJ/1v70GQX24QPX9L0ngLIzq/m/KbPRufvz3lfEzjeCq3/mI50cDBjc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199024)(1800799009)(186009)(478600001)(8676002)(110136005)(7696005)(71200400001)(53546011)(6506007)(9686003)(2906002)(966005)(64756008)(83380400001)(26005)(5660300002)(66556008)(76116006)(54906003)(66946007)(8936002)(4326008)(66476007)(41300700001)(52536014)(66446008)(316002)(33656002)(55016003)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3E5R05qS2JkRStpQ1NsZGJlRGNuUEgvZ0RJUDFIdS9BZWFwUHphbUJpUE96?=
 =?utf-8?B?Y2ZJK3kwakpJZStUNEN2TFVFSWhwZnk1T2lFanB6ZXVmRFIzT0xnR1lKbE85?=
 =?utf-8?B?NnB4QWsvQTMzb24yck0xT3F2OWlFQ2J2NWIydWNsQlNxbWx1ZkZRODBlR2hJ?=
 =?utf-8?B?bHV4R3FqWEVYVmdNVk1WZ1hiVDFPNzh5ckhwMmtYR09ncWR3akpGaXh3Njlo?=
 =?utf-8?B?NllPc1k0MGR3VkJ3MVpBRDNieGxCN3FBYkx4ajE1L1ljZE45a3VWNXMwaktx?=
 =?utf-8?B?aVlrVjdmaHVHek56V2tZRHNFUlBhZDU1L3BNYjkvVmFsMnJNTm0yMGJJa2U4?=
 =?utf-8?B?VHN3dHIrby9SM0t1RGlWOHJVYTNlNkcrMnJGYUdEL0txOFppdDVJUWI3d2pa?=
 =?utf-8?B?bWlBektKa0VPLzVRUXJkcnp4NWcxRTFpVTkwYytxaFlvTW5lbkdDaVBnTmVj?=
 =?utf-8?B?ZXFyWFltb2MxTE1JekwvSjVCVUVRS3c4NGJ4d2pqdjdmN0JqNEFyOWJzUk43?=
 =?utf-8?B?OWZNNjlBeVNyb0J3amNGcjUwOU03WmtieXFBMUVyYWk3UmFaTGw5cGNmRkkv?=
 =?utf-8?B?RW1Yd1ZOOHdvV1VmdzFxbFVrcDEvbHN2ZEtYaDR1VjdydjMrL3o3bkw1K0RR?=
 =?utf-8?B?c3kwakMxSFJWVTlDZVA0VWhsZCthSU15M3RaMjVwMWl2Z3g5QmRsYkhRR0hF?=
 =?utf-8?B?U3NZaVNYK0ZYdlo0cFNnQmFGSUFzUW8wV1pSM1dtVmJjRmp5eWxlY2VscUtl?=
 =?utf-8?B?ckYvS2NwWGdMdmc4VFduamVhV05RNlExa0FKZ1JXYTU2TDJZZHR0cnFZQ21p?=
 =?utf-8?B?S0MyZkk1RGtEcDV4MlBRWTBkNHBGMlJZRTM0eDNiSGMyL05RMkowR1V1anRp?=
 =?utf-8?B?cWg0d1Qvd3lGYXpqTERYdHE5N1MwNVlLZE01Q0hBZkE5QVc5N3ZIbm9RN2R6?=
 =?utf-8?B?U1JHNGFkdU84QllYaFltREE2eGdqNURuM2J0ZFlMeU1IVWZLSkUxdHNSbElN?=
 =?utf-8?B?c1Z0MnFBbEYrN08vdCtOYVQzZW8yMnFnNnBYb1Q3ZmpodG81c2NGL2xVU3B1?=
 =?utf-8?B?TUtWczJsRUVONmlndk4yL0VRQ0VVWVFjMnF6VDlSZVYyQ2dPRUZsc21TanZv?=
 =?utf-8?B?WEllYnpRMjBSMllPdVhISW1hczUyNXVtaUJaYm5YSDE2WVFXMzhRVmRNcVFW?=
 =?utf-8?B?NmNXM3dCTk5tSXR4R0U0KytDM1NUeGV5dm9YYnJwWWlrak56aXk2S3VpbmE5?=
 =?utf-8?B?aGVXai9FNjZGanJCcWFsSlJweDdsSHNqL2RTUDBSKy9tWkx6K2R4SytpS29m?=
 =?utf-8?B?SjV0Uko3cnhaWnhRZmpDTHFIclJTL0p4ZnpzTWR3MG9IbjE0bWthWm9zeVM4?=
 =?utf-8?B?b2pDdlIya25Sd0VqVDlzcWgwckRDa3NuR2xadmlHZlZEWUtheHNHRm9uTnIy?=
 =?utf-8?B?MkIyRUVPQ0ZYS2JNU3gyQ09sR1VycjZraElNZE9jODlvWnh3aUl0ejEyS2wr?=
 =?utf-8?B?YmtKYmwrQ2IxUktSazJkTDNtcUprS0ZLQW44RWtGZ2V0RmE3bjlzSzhmUzJo?=
 =?utf-8?B?MnJHVzZlakVxUzhpSXBJRVg2QUp1RlJmOHhlQjdVREkvUElWTTZQMWFOcndR?=
 =?utf-8?B?dGtCRmU3YUJWYXFkcFBBTFJxdVhFNndoN0M4c0VYaWhsdktYTUVua0MzVEdv?=
 =?utf-8?B?a1JMbklMNFZmYnVlTGpsNHFaWm10NnROMlord2NIUHpCa3dRVGVsakVTNGY3?=
 =?utf-8?B?SjhaczlTL1JCOG5vTDY3U1lMY1VZOXlzbytSczdxeVdlV2NyYlVjeTRTL0pn?=
 =?utf-8?B?K0hhU2VYV0VTaERoQU85dEVhcmIzNy9nRW16V29pUC9XUUxrL3JPb3crbTVx?=
 =?utf-8?B?bmJKTjZKNlBnLzN6RUtGdml0Y3VONVZEbTZxM3hPaWlDd1F6L0UvL3VpVFNE?=
 =?utf-8?B?a0YyZTh6YUJDVWUwNXMvT3FmTkxzMVllREZLdVZPeTBSZWx6L3J5blNtMmM3?=
 =?utf-8?B?TVdYWFVZbTBsaXVWY0dIMWs1M0pFY2hqWkNxcnZOVjJMZllZYVpYMkhvU2g5?=
 =?utf-8?B?Q29wWU85K1Jkb3hPeTlzb1FpMkJKWTNnV3gxRHRMQzBsYmdSTkwya0NRTURZ?=
 =?utf-8?Q?UZKA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc0fa47-71a7-486b-5dd0-08dbb3656a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 07:53:55.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrpmNq3IQ4cd6UjZlQjtwXhFXeC8RuhL6fS/3v7d6C8drmoXMvkRiJH1763fl9gjO8Y9iuFzKyQUuyzuFm4JAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAxMjo1OSBQTQ0KPiANCj4gT24gOS8xMi8yMDIz
IDI6NDkgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEy
LCAyMDIzIDEyOjA4IFBNDQo+ID4+DQo+ID4+IE9uIDkvMTIvMjAyMyAxOjUxIFBNLCBQYXJhdiBQ
YW5kaXQgd3JvdGU6DQo+ID4+Pj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGlu
dGVsLmNvbT4NCj4gPj4+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjMgOToxOSBB
TQ0KPiA+Pj4+DQo+ID4+Pj4gT24gOS8xMS8yMDIzIDc6NTAgUE0sIFBhcmF2IFBhbmRpdCB3cm90
ZToNCj4gPj4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+
DQo+ID4+Pj4+PiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyAzOjAzIFBNIEJ5IHRo
ZSB3YXksIGRvIHlvdSBzZWUNCj4gPj4+Pj4+IGFueXRoaW5nIHdlIG5lZWQgdG8gaW1wcm92ZSBp
biB0aGlzIHNlcmllcz8NCj4gPj4+Pj4gQWRtaW4gY29tbWFuZHMgZm9yIHBhc3N0aHJvdWdoIGRl
dmljZXMgb2YgWzFdIGlzIGNvbXByZWhlbnNpdmUNCj4gPj4+Pj4gcHJvcG9zYWwNCj4gPj4+PiBj
b3ZlcmluZyBhbGwgdGhlIGFzcGVjdHMuDQo+ID4+Pj4+IFRvIG1lIFsxXSBpcyBzdXBlcnNldCB3
b3JrIHRoYXQgY292ZXJzIGFsbCBuZWVkZWQgZnVuY3Rpb25hbGl0eQ0KPiA+Pj4+PiBhbmQgZG93
bnRpbWUNCj4gPj4+PiBhc3BlY3RzLg0KPiA+Pj4+PiBJIHBsYW4gdG8gaW1wcm92ZSBbMV0gd2l0
aCB2MSB0aGlzIHdlZWsgYnkgZXh0ZW5kaW5nIGRldmljZQ0KPiA+Pj4+PiBjb250ZXh0IGFuZA0K
PiA+Pj4+IGFkZHJlc3Npbmcgb3RoZXIgcmV2aWV3IGNvbW1lbnRzLg0KPiA+Pj4+PiBbMV0NCj4g
Pj4+Pj4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVu
dC8yMDIzMDkvbXNnMDAwDQo+ID4+Pj4+IDYxDQo+ID4+Pj4+IC5oDQo+ID4+Pj4+IHRtbA0KPiA+
Pj4+IEkgYW0gbm90IHN1cmUsIHdlIGhhdmUgZGlzY3Vzc2VkIGEgbG90IGFib3V0IHRoZSBwb3Rl
bnRpYWwgaXNzdWVzDQo+ID4+Pj4gaW4gdGhlIHRyZWFkcy4gSSBndWVzcyB3ZSBzaG91bGQgcmVz
b2x2ZSB0aGVtIGZpcnN0LiBFLmcuLCBuZXN0ZWQgdXNlIGNhc2VzLg0KPiA+Pj4gWW91IGFyZSB1
c2luZyBuZXN0aW5nIHVzZSBjYXNlIGFzIHRoZSBfb25seV8gdXNlIGNhc2UgYW5kIGF0dGVtcHQg
dG8NCj4gPj4+IHN0ZWVyDQo+ID4+IHVzaW5nIHRoYXQuDQo+ID4+PiBOb3QgcmlnaHQuDQo+ID4+
Pg0KPiA+Pj4gSWYgeW91IHdhbnQgdG8gZGlzY3VzcywgdGhlbiBsZXRzIGhhdmUgYm90aCB0aGUg
dXNlIGNhc2VzLCBhdHRlbXB0DQo+ID4+PiB0byBjb252ZXJnZQ0KPiA+PiBhbmQgaWYgd2UgY2Fu
IGl0cyByZWFsbHkgZ29vZC4NCj4gPj4+IElmIHdlIGNhbm5vdCwgYm90aCByZXF1aXJlbWVudHMg
c2hvdWxkIGJlIGhhbmRsZWQgZGlmZmVyZW50bHkuDQo+ID4+IElzbid0IG5lc3RlZCBhIGNsZWFy
IHVzZSBjYXNlIHRoYXQgc2hvdWxkIGJlIHN1cHBvcnRlZD8NCj4gPiBNb3N0IHVzZXJzIHdobyBj
YXJlIGZvciBydW5uaW5nIHJlYWwgYXBwbGljYXRpb25zIGFuZCByZWFsIHBlcmZvcm1hbmNlLCBo
YXZlDQo+IG5vdCBhc2tlZCBmb3IgbmVzdGluZy4NCj4gPiBJdCBpcyBub3QgbWFuZGF0b3J5IGNh
c2U7IGl0IG1heSBiZSByZXF1aXJlZCBmb3Igc29tZSB1c2Vycy4NCj4gPiBJIGRvbuKAmXQga25v
dyB3aG8gbmVlZHMgTSBsZXZlbCBuZXN0aW5nIGFuZCBob3cgY3B1IGFsc28gc3VwcG9ydCBpdHMN
Cj4gYWNjZWxlcmF0aW9uIGV0YyB0byBydW4gc29tZSByZWFzb25hYmxlIHdvcmtsb2FkLg0KPiBO
ZXN0ZWQgaXMgYSBjb21tb24gdXNlIGNhc2UgYW5kIGl0IGlzIG1hbmRhdG9yeS4NCk1heWJlIGl0
IGlzIGNvbW1vbiBjYXNlIGZvciB0aGUgdXNlcnMgeW91IGludGVyYWN0IHdpdGgsIGl0IGlzIHJl
cXVpcmVkIGZvciBzb21lIGNvbXBsaWNhdGVkIG1vZGUuDQpIb3cgbWFueSBsZXZlbCBvZiBuZXN0
aW5nIDEwLCAyLCAxMDA/DQoNCkkgZG9u4oCZdCBzZWUgYSBwb2ludCBvZiBkZWJhdGluZyB0aGF0
ICJuZXN0aW5nIGlzIHRoZSBvbmx5IGNhc2UgYW5kIG1lZGlhdGlvbiBpcyB0aGUgb25seSB3YXki
IHRvIGRvIGRldmljZSBtaWdyYXRpb24uDQoNCkFzIEkgcmVwZWF0ZWRseSBhY2tub3dsZWRnZWQs
IA0KV2UgYXJlIG9wZW4gdG8gY29udmVyZ2Ugb24gZG9pbmcgYWRtaW5pc3RyYXRpb24gY29tbWFu
ZHMgdGhhdCBjYW4gd29yayBmb3IgcGFzc3Rocm91Z2ggYW5kIG5lc3RlZCB3YXkuDQoNCkkganVz
dCBkb27igJl0IHNlZSBob3cgbmVzdGVkIHNvbHV0aW9uIGNhbiB3b3JrIHdpdGhvdXQgYW55IG1l
ZGlhdGlvbiwgYXMgZXZlcnl0aGluZyB5b3UgZG8gdG91Y2hlcyBkZXZpY2UgcmVzZXQgYW5kIEZM
UiBmbG93IGFuZCBpdCBwcmFjdGljYWxseSBicmVha3MgdGhlIFBDSSBzcGVjaWZpY2F0aW9uIHdp
dGggdGhlc2Ugc2lkZSBiYW5kIHJlZ2lzdGVycyBhbmQgZmFraW5nIGRldmljZSByZXNldCBhbmQg
RkxSIHdoZW4gYXNrZWQuDQpUaGlzIGlzIHRoZSBwcmltYXJ5IHJlYXNvbjsgSSBhbSBsZXNzIGlu
Y2xpbmVkIHRvIGdvIHRoZSBpbi1iYW5kIG1ldGhvZC4NClVudGlsIG5vdywgbm8gb25lIHRlY2hu
aWNhbGx5IGV4cGxhaW5lZCBob3cgaXQgY2FuIGV2ZW4gd29yayBvbiBxdWVzdGlvbiBmcm9tIHll
c3RlcmRheS4NCg0KQW5kIGlmIHRoZXJlIGlzIG9uZSwgcGxlYXNlIGV4cGxhaW4sIEkgYW0gdmVy
eSBpbnRlcmVzdGVkIHRvIGxlYXJuLCBob3cgaXMgdGhpcyBkb25lIHdpdGhvdXQgaGFja3Mgd2hl
cmUgZGV2aWNlIHJlc2V0IGJ5IGd1ZXN0IF9hY3R1YWxseV8gcmVzZXQgdGhlIHVuZGVybHlpbmcg
bWVtYmVyIGRldmljZSB3aGlsZSB0aGUgZGlydHkgcGFnZSB0cmFja2luZyBpcyBhbHNvIG9uZ29p
bmcuDQoNClNvLCBteSBodW1ibGUgcmVxdWVzdCBpcywgdHJ5IHRvIHdvcmsgdG93YXJkcyBjby1l
eGlzdGluZyBib3RoIHRoZSBtZXRob2RzIGlmIHBvc3NpYmxlLCByYXRoZXIgdGhhbiBkb2luZyBl
aXRoZXIgb3IgbW9kZS4NCg0KDQo=

