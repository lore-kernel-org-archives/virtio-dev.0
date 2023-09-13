Return-Path: <virtio-dev-return-13733-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E13CA0ED1
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:15:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D861C70FF0
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:15:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1895986642
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:15:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B198098612D; Wed, 13 Sep 2023 04:15:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1439986630;
	Wed, 13 Sep 2023 04:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr0GYePewsojrEmrRjhA6EYvGifrwdxXrBqVq5pr0cHP6jX8ZIyY0zNlU3ZCm2/Wp7ZVtCDYRNfXPWOD+awZXllB2KneW3aXVJzOyLWb3PjQ004vyFlCWARH6rzEFdWaC3Xl0sosL818WriEPTwwq9t5+tiJZomI05jvGA6+kUDUfUxgjj+7QNb/o6SHYyc8f/zvYuCQX+566x1/WCIymwzAVTrLDHfivH0ao2x4K0LMAqjuJYIM6bxSoD1SLrQ4SGiGD+qJTiAzv6spfITU0IoCkLCy9oY6pDO8K6HR+cq5nHm/hBnp9l0ElDaEAPw7eM0oK5e1tvzSU2+KrrMLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVIk6NRZKwX1weQ8ux2OsqP+Gq/HaPildo96spHAFWk=;
 b=cTLKWIo+ZRqS+G/tMl/3pOqBkFuOfRNwCd0AgTdDSFjwI6EyEF8BvXcPAZVivSP/VFDu/S0ZQJSOb82tGd9KyMDEflVFfEs/HfIbbUo9QHko46YN98q7kMB59Lj7KLj/L/dTRkZ4ZmZ5uoGOmazoMFbe97Cihds6ApWVds9l9D3tjFBL4aF2dcJdn6jYSacYCvOSozDIwfsfRxqiEXr3U3irDeUn74rbusIR3kbPsQp1Ob7qNfZa7e5pu61amy60BSh8SXVVpBHphBSvp2XDePMRAu8VuBJCuLyPeKJgmGvfyi4u4D9FpMXH6VoS9s/OMnsTeZOavewBg+GQHD2xog==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAAAKAAgAAF4bCAAAyxAIABDe5ggAAckgCAAAKaYA==
Date: Wed, 13 Sep 2023 04:15:02 +0000
Message-ID:
 <PH0PR12MB5481BB050713B687EDD07FB2DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
 <PH0PR12MB5481EF64F3BA3D13C34D016EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2f34daa5-3db3-fd64-550d-86678acbfef4@intel.com>
In-Reply-To: <2f34daa5-3db3-fd64-550d-86678acbfef4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB5000:EE_
x-ms-office365-filtering-correlation-id: 21f74f8a-07ac-43e4-6d02-08dbb41000b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dwKaXZFs8G9hznZn4WmLJncY/w9F4gZYvXIuoaCQCOy42t6SF4qOP4lNsRPLv2oWRH6I25az7OWlF0GLiSkPT8brvIc5LmsYLs4q9mFOLJWl1fgukUEwHeA9tpOr8PScSnjUSIRhz5CZzqV2Gs7Hpms4UyzOAs0l8ASgGT5Q7EJReVsGc9l7yI42i5B8KZ9lgIiZw+f//fppFDGBQ7IpKbKpoiiPvsxy79g3C3ZtxW6gOR2Ch8wWZlukxuq8qFJcDEr5yJIUW4Fsu7P30hTYoxWUJ0SUP+zRQBFXTProiF7Akhf6LBm5PExvc/Ij4Mfk/pA/C2tioNIrZU+cwdGk/yy5/FBOTgXmUpTpDdtQeG9c/2wNaWvGtg/GeBfzE/u9mORmlwJuPgorj94WB0aegLQRLo9VMJAxsV9tyLTCk4Q+wMrBeisweBXEWyPKkG4tIkHwes0pxkHB8/bH+WpcUY3dvyda7r3BvBrhI5Db5+2AFzUIJmRyEemvrfNKYTGTj0f14pTZ3VfUXVh9j5lanLrZWLnxeIGiohrpyYDyy6K84+F/PYQ+9Zkd2aqYXm6rzVlTSLDpoU2WQP/1Lu/uLABkQVoLWlrXhvvohPiwTAAbAPVLc4/bm9U2d1oDD6Y0ukdk1TEdz8Z+Cq8M+PYQtyDAiD8YPG8m9HlgUj2PPHY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199024)(1800799009)(186009)(122000001)(6506007)(53546011)(71200400001)(7696005)(41300700001)(33656002)(38070700005)(55016003)(38100700002)(86362001)(2906002)(966005)(9686003)(83380400001)(110136005)(8676002)(52536014)(5660300002)(8936002)(26005)(478600001)(4326008)(64756008)(54906003)(66446008)(66556008)(316002)(76116006)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlB2YUoxOVJKUXR5Vy9ZaUpvdG9mTm9tdGJ6UEdFUTNvNXZvZ01CUkhJcW9R?=
 =?utf-8?B?TDQ5c2RIcGROK3laQTlJTGtwV0FkRTZnb09WZWZaSWRBRUx1YjJkVHFLeSt5?=
 =?utf-8?B?YXJXZ0hBMm55YTNnSXpsNXJjbHdiUHFZTG1UcGdpdG5UQWV0Y2EvVHJ4a0ti?=
 =?utf-8?B?OE1aSzNjc1U3bTdudnFyakg0TFJJckJNdWpvVW1zaW5Da05zblliNGJjQXFw?=
 =?utf-8?B?bkFNcDBWaDMwaXlrWDJRRjI5a3NBMHppbmRtYWJDZGJLamZ6Ukp5OVNlVFJ5?=
 =?utf-8?B?UlM2bE9IVFA2a0k0Vkw5blIzYnY4UjJUenNCcWVBOW5nWVJiV2I1MmhFNTBz?=
 =?utf-8?B?Q3ZJYnluaUJUVUU3R3R5blFGM0hzVWxFd2hUbzVDQTJadjFYTnpQa2xzcmRh?=
 =?utf-8?B?WFZRKy9xLy9oM0hNVzZtQ0FKMkFXNTllVHd2MWZYZlNTSHJaK2MrYzdHS3Uv?=
 =?utf-8?B?T1RORTVwd28xRmxtQjV3YzNDZmhYWEUwZGhKMVdpZkxYSU1JSkhVOG9BUGtp?=
 =?utf-8?B?UE9Cd2FzUGJQRzRKZk5LejBTRkxpRTRHNFgweEhoa2h4Sm5TTkQrTVljMVdZ?=
 =?utf-8?B?NUNOTDNDdmpSc3VEM2hocDlpcmY5Sk8zOGtDS2ZWSUdMclB6L1ZSZ1BEV0lW?=
 =?utf-8?B?bWNmK2M4dUQxUjdxNGZRTVNxbTFCOGtmNGxSK0tXY3l4bHRMRTZiallCNC9u?=
 =?utf-8?B?b3VlU0VpcDNLR0tkd1NPc1hoK0VZMnNiUzlDYjVNMFRHWXFnbkdjZlFQUGZh?=
 =?utf-8?B?T2RNVlI2TEZGelRpRC9KUUZnUUcyYWtWSWN4SHkwMWlSb2RkYXBkQXlwZzdC?=
 =?utf-8?B?UlpZa05xcVlDVTdOTkdVMExwbjFiODRlSGNaQlVNU1NLYWNhUi9RaG45RlRT?=
 =?utf-8?B?RUo1R1hpMVhSNUl4RXhzQTh3ZjRhL1NUdFVNNzRVME9KeWNFSkNVZU1yU21S?=
 =?utf-8?B?TjZXMXk0TlNxa1BNd0IrcEZudjh0MEFVNUEvckFpRGVxOC85NFgrVG5HNHow?=
 =?utf-8?B?VklpWktVWUJCakp3SDA1cWFuWHJkZXZNQ1gwSDN2eHRPVFIvTU1VUmdQL2t3?=
 =?utf-8?B?U1gyamkySmRzeTRISWFTdTVjOTdYaThkS3VteEgwSEhwV0RkVDUzYnVpanYv?=
 =?utf-8?B?S3dYVjBRS3lxanV3akdQVGRod3A0QjFqREVTaEtUb3Z6LzJvVHhiUGZtTmMz?=
 =?utf-8?B?LzdYOW1CbG9nSlZxd3FUTWlkMk1LdFdNT0lFOE1ScnR3WG1IVlU2SWNpYmEz?=
 =?utf-8?B?NXlsbE5xQXk3c3gvMzQyWU53SkpHb0lSeGdBZTBpMUVNMmlrenVRTmwvNitR?=
 =?utf-8?B?bUlCYW9JNlM0Slp0RFZ5NFRnazUxMm9Rb3dId2JhUGtIenAxOGlhdWhidEpt?=
 =?utf-8?B?eTI1Q1ErV1pjeHA5RTUyMHZXbjJxbEtQSUk0amkzSlViNkZPRVJNSklZMlUz?=
 =?utf-8?B?d01wci8zSFpYR1BNQTRra01FRmpTWDdleWg1a1RsSVVPZVFCMGtwZ0ZXd1V3?=
 =?utf-8?B?TEM2c2ZJNEhPUXQxRWV3RGg0SW5GaFl2TVIvS1hkaC8yVURBVTJrazFRaFVS?=
 =?utf-8?B?V2Z5Mjc5N1dDR0t6MCtrZ3ovb1ZaTDROdXhHb2UxOEYyWXFWY2hLZjRaT0Jn?=
 =?utf-8?B?ZFVJc2xWQjFvUlpLTWZrQ2E0ZjJvbHBoS2lXZFJENG5xbHJLL2RGSTU1bW9Y?=
 =?utf-8?B?NkgxMnJ4cjduUlMxSGx6SkJ6L3h5bkJzMkl6RDJMQmwyS3NuS3h5R2JhQjY0?=
 =?utf-8?B?SDJIcWNhd3cxWDhNcHFLSCtCRG1lYjR2THRITVh4M01ST0Z1dGo5VWI5UWlt?=
 =?utf-8?B?c2lyVlR4ZEZwZjlVOTl2d2xjaG9XV2YwOXVlaUZUbTFLR2FSY3FlV2hBNXpY?=
 =?utf-8?B?SG9oOEhuUjFSM1JINytKYVB1b0phQ2RyNjBDTHJGMjdIZWl6TU0zdXl1TnBO?=
 =?utf-8?B?bGVram1oenEyK20zancxTS9aNDJtVVl2SW1NSHlDYjZjK1BScm1iRU1oVzIy?=
 =?utf-8?B?bjdsOGlDMktkTFh1c3UybGxhVzBONVZUVXFCRlFTRjJiYWlaV0liUTVReWhh?=
 =?utf-8?B?YUZINE1ZbzJYVXVUYWRlUHBNbktUKytJc1VDMjhQQ01ZdTEzZHNWOUJaNDZX?=
 =?utf-8?Q?/neU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f74f8a-07ac-43e4-6d02-08dbb41000b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:15:02.7192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUMNEKWigjo/HmEgfxecFf6LN20hmQkFWlOC2G8rMz1obVtFlTdxBan39vHdeH+iyz1YC/lesK4Qb8c7D+iurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIzIDk6MzMgQU0NCj4gVG86IFBhcmF2IFBhbmRp
dCA8cGFyYXZAbnZpZGlhLmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+
IENjOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgZXBlcmV6bWFAcmVkaGF0
LmNvbTsNCj4gY29odWNrQHJlZGhhdC5jb207IHN0ZWZhbmhhQHJlZGhhdC5jb207IHZpcnRpby1j
b21tZW50QGxpc3RzLm9hc2lzLQ0KPiBvcGVuLm9yZzsgdmlydGlvLWRldkBsaXN0cy5vYXNpcy1v
cGVuLm9yZw0KPiBTdWJqZWN0OiBSZTogW3ZpcnRpby1jb21tZW50XSBbUEFUQ0ggNS81XSB2aXJ0
aW8tcGNpOiBpbXBsZW1lbnQNCj4gVklSVElPX0ZfUVVFVUVfU1RBVEUNCj4gDQo+IA0KPiANCj4g
T24gOS8xMy8yMDIzIDEwOjIzIEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFpo
dSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXks
IFNlcHRlbWJlciAxMiwgMjAyMyAzOjQ1IFBNDQo+ID4+PiBEbyB5b3UgZmluZCB0aGUgYWRtaW5p
c3RyYXRpb24gY29tbWFuZHMgd2UgcHJvcG9zZWQgaW4gWzFdIHVzZWZ1bA0KPiA+Pj4gZm9yDQo+
ID4+IG5lc3RlZCBjYXNlPw0KPiA+Pj4gSWYgbm90LCBib3RoIHdpbGwgbGlrZWx5IGRpdmVyZ2Uu
DQo+ID4+IE5vdCB0aWxsIG5vdy4NCj4gPiBJIGRvbuKAmXQgdGhpbmsgeW91IHJldmlld2VkIFsx
XSBlbm91Z2guDQo+ID4gRm9sbG93aW5nIGZ1bmN0aW9uYWxpdHkgdGhhdCB5b3Ugd2FudCB0byBw
b3N0IGluIHYxIGlzIGFscmVhZHkgY292ZXJlZC4NCj4gPiBXaHkgY2Fubm90IHlvdSB1c2UgaXQg
ZnJvbSBbMV0/DQo+ID4NCj4gPiBhLiBEaXJ0eSBwYWdlIHRyYWNraW5nICh3cml0ZSByZWNvcmRp
bmcgaW4gWzFdKSwgYi4gZGV2aWNlDQo+ID4gc3VzcGVuZC9yZXN1bWUgKG1vZGUgc2V0dGluZykg
Yy4gaW5mbGlnaHQgZGVzY3JpcHRvcnMgKGRldmljZSBjb250ZXh0KQ0KPiA+DQo+ID4gWzFdDQo+
ID4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8y
MDIzMDkvbXNnMDAwNjEuaA0KPiA+IHRtbA0KPiB5b3UgY3V0IG9mZiB0aGUgbWVzc2FnZSwgSSBk
b24ndCBrbm93IHdoaWNoIGNvbnZlcnNhdGlvbiB5b3UgYXJlIHJlcGx5aW5nIHRvLg0KPiANCj4g
QnV0IGFueXdheSwgYXMgcG9pbnRlZCBvdXQgbWFueSB0aW1lcywgd2UgYXJlIGltcGxlbWVudGlu
ZyBiYXNpYyBmYWNpbGl0aWVzLg0KDQpJIGFza2VkIHlvdSB3aGF0IHBhcnRzIG9mIHRoZSBzZXJp
ZXMgWzFdIGNhbiBiZSB1c2VkIGJ5IHlvdSBmb3IgaW5mbGlnaHQgdHJhY2tpbmcsIGRpcnR5IHRy
YWNraW5nLCBzdXNwZW5kL3Jlc3VtZS4NCllvdSByZXBsaWVkLCBub25lIGlzIHVzZWZ1bC4NCkFu
ZCBhZnRlciB0aGF0IHlvdSBzYWlkIHlvdSBwbGFuIHRvIHNlbmQgdjIgdGhhdCBkb2VzIGRpcnR5
IHBhZ2UgdHJhY2tpbmcsIGluZmxpZ2h0IHRyYWNraW5nLg0KDQpTbyBJIGFza2VkIHdoeSB5b3Ug
Y2Fubm90IHVzZSBbMV0gdGhhdCBjb3ZlcnMgdGhpbmdzIHRoYXQgeW91IHBsYW4gdG8gc2VuZCBp
biBmdXR1cmU/DQoNClsxXSBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3Zp
cnRpby1jb21tZW50LzIwMjMwOS9tc2cwMDA2MS5odG1sDQoNCkhvcGUgdGhpcyBjbGFyaWZpZXMu
DQo=

