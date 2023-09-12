Return-Path: <virtio-dev-return-13712-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0579ACA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:25:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 32CBF70FF8
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:25:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 290059865B7
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:25:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 180D9986485; Tue, 12 Sep 2023 10:25:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05E8698648C;
	Tue, 12 Sep 2023 10:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isRuKKNv1aEixDogWACmLInaV4Zqu/2VzTP0x/XFRRfnTR94H1EKl4a0A0ioc2vvW1FiIfih1b/5WzblK/+DhjbUWu8d0al4fzEatoSxEmdwmX1o64Zv6hladFV5BUmOokugmeqAn/+GMY78buyIRUmREnp7iTFCYXwXnQ2Gw1sUxwVStpOU+Qflh/qR9BRUszWkD+YgeElkEHv4I6Lb03ZoFORz+hoW9uuQDENso73YwvSKOaNqRh/T5aexjVdmzhi+W3Kxw1xnJBd/VsVZlZB6a4+SVv8fq/JBKIBscJ+thxtFjyBbsDYzG8whBNmcV5Q1R2BcfoQeBDm/i66+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siIJMjB8fo65cjg1m2TKhrfaOYz8ZHwcdWi0LFyz4eM=;
 b=B1t9WugAho8OX5UbCIbtTsFL5cEQK/VFhYB4StbBAQ9/410tYaJLx5h351dckgAbEUQk2hAfrbWHOB9cI3MMT46iEcwoskXZ39u0HDUJfSrCqEZILHNItEMJqs6A+cIYkoaxsAUyAd+33f+4bU1E7NScEdNmQE0zCV17acCSG2XWrqUsfHIOIG/l/Xg8yg6zgydUPtXVfGyXyXNKyj30CdkbdPi6Nie8+gI1fKLz86agdqZ/CjeWTJhco/SMfVKFTlWcYKQicVdKMwkiHy+edu5415YdTbyDvGs4MgRd/G3EtaD9QEhShE67mtsXIA6X89KjMZydksNtQXLvROoXCQ==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAABGsggAAPgQCAAACMgA==
Date: Tue, 12 Sep 2023 10:25:40 +0000
Message-ID:
 <PH0PR12MB54815CE0845F866CD8125662DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
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
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <PH0PR12MB5481036BC22785DC22A394D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c39bfe6-1acf-6ee7-2a0c-1861fa680eb4@intel.com>
In-Reply-To: <4c39bfe6-1acf-6ee7-2a0c-1861fa680eb4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8695:EE_
x-ms-office365-filtering-correlation-id: d829d98d-bbf5-4609-d80e-08dbb37a9d42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 y3K+M+W4rEUNyg3lEK5IzM/YSMvwoJL7HH+ixwCrub1J4uOrC4Njl98PCIe/qXBEQeN5DLs28WrFFcPU0tiALe1ONMulpR4LJRoALL7dv8xPpPp134nxxkMsdw2pqI3+OuFYoE5zhJO/UlqqRpAjH1j+/NWenlFZo1Y4uUy1Q8aHWpfmUF0im+m40MbI4uK/eUKWMdJA8rORB7JtG85zjgDywGT2bMCtapOLsNFeRoFTH/D/zv3PDethG25/oWXG1CzWB4CsPAzQkMPk8EesT0zRBFTkGRo+uAf6rBMWfHWGkXIQwG2f3a73ZbSwAT87OZqRUKIK1aiH7YHZQfriHEAHxfYVBPjWNd+qx7niC9vx7lr0HTgPoKj32B2k1bP9dF1oAPkQgH2ldb8syOnPqzyI2wY/FtJKNbnsTclktce0E6D/VKa9iM7J5Y3LbJV0FMkExAg5bChAVkxBIswYSvNTopAYdqdPxUkNjLCDN5Gpz1xShxYkR/+CyzSUPZgwNwj0xhsisycGdibJR7zK240StMTqMV7r2jJ7N6gRzWU15+OpqE1vgSKLdmMzPJ5kpqr6ck/ltTiRCIcB4TBCn4YJGefSRXsiDtw2wRRZRC5qwPx70nwPUzmTJf4y5oINv8z7ASxagThlmTiWWGrwChDOQ2ckJ/m7wq90f81TiTo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199024)(1800799009)(186009)(52536014)(66476007)(76116006)(66946007)(53546011)(66446008)(66556008)(54906003)(4326008)(8676002)(478600001)(64756008)(55016003)(122000001)(7696005)(110136005)(6506007)(41300700001)(9686003)(316002)(83380400001)(5660300002)(26005)(71200400001)(966005)(8936002)(2906002)(86362001)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2JyZlFMSHFUY1NFd0EweGlqdWRBUzlrZ3RTTkhMeWR4Z0g1OXgvdmJZN2hN?=
 =?utf-8?B?SkJmaUQ1Y09SLzNFWWx0RzNBTnNaQlk5UUk2YW5qbGRiUjM1aEQ2Qy9SOXZt?=
 =?utf-8?B?VW84TE5PWFd2SjU2Q3BSeWgyTFZwK2lQNW1IbVRrV3pCazdWTFJtTXZIWUtl?=
 =?utf-8?B?QlVsMEkwZ3dGckVGemxZajBWMy9SQys2WTBMTTBPT2tWdS9OazZVVWFRZmt2?=
 =?utf-8?B?WWlFRHpvUDQycE9jaFhuL3R1T3dzb1FOSnpRcXZlVmNCOFdaa25pZGZLQkN1?=
 =?utf-8?B?TmJUZ0tLdktObldCMFp0Vk1BS1B1Mm1pZGV3NzNyNGxwbkpHam1jQk01dkRX?=
 =?utf-8?B?dDNGeTJOMXZ5d1l1RnVFaUw4cUlIS0s0dHdyMjZwZW1Ja0tPdUR6eWRXYmcy?=
 =?utf-8?B?enAwTzJlaC9UTkpKZnk3Wkd6RzJ5UXdZblVycXZ0eU04NFMrUlRWd1QwZ0x5?=
 =?utf-8?B?NjlUeWg0ZUp2QVZCYjkwK0hKV1hROE1KVlN2TExhWjBwZ29JQlRBRGthMExC?=
 =?utf-8?B?N3M3UTVpRmZvRjJCL3IydzZOUjRYc0RURWl1K0Q2L054aXBxKzJUUUNNdlhS?=
 =?utf-8?B?Vkp0SURpMWVLN2gzU09HSmphR3o3bVJmNlRzbUc2NWRHMENBNTJIaFluQTND?=
 =?utf-8?B?ZVBrTXhXc2hnTUdFM1pjeW8ydWErYUdzMkR5WmhVZUFHR29Yd1dNR1JXOVZS?=
 =?utf-8?B?ZnBldE5nQmhEUXRzN2IwVVV4aW9IOXNRV2xsaFBFN0lMOXVHQWpiaFBWTlZC?=
 =?utf-8?B?WlhWcEJzZWFpMjBCUFlnODdHTFJNV1QzRURmdVI0b1pTa0hIbk01TEZ5UzJx?=
 =?utf-8?B?RmIvNFhjeUZySi9DZkJCNkFUSk5Id052TmlzaXI2Y1dBdzN6ejB6Z3MvZjRa?=
 =?utf-8?B?aVd2MlVkeVlxQ0J2UmZaT2x4Y1laUnVJZVg3UnNSWWdVcE84OWRmaEhaT0Z6?=
 =?utf-8?B?VzhGVklzT0hLVEFLRlNtM0R2QlZlWW14bDdvWDJHaDNwMmFQVFg4dGZEdEN0?=
 =?utf-8?B?eVVteHBiYi8vR0ttTE9TcGtOdnM1VWFHTGNqMCtubEFTbTMvZmtWa3BlOENu?=
 =?utf-8?B?Mi9DQ09hZGRaTlViblJER3hEYkpLUkNmdGVFcjlTWnFCa1BYYmR1MmIwWEJy?=
 =?utf-8?B?dUU0clNDWUNWWTR2YjFDVFd3akcvaW9rYnQ0Qkx4NU4zMktwKy9kYWtqSWVn?=
 =?utf-8?B?Q2lNNHc5cHBPUEVwSlhaQ0g3dndGQmZ5bEhtQXlNSmdJai84eThQREFsN1c5?=
 =?utf-8?B?S0VGSGh6WkE0bzdRNzRYMFRWU0kvRkFZcDVVQ1BCOUxZZHBzRFQ3UFRZWFdJ?=
 =?utf-8?B?dFloSjMrQUQ5TWdMZUFlMXpOcDN2SGlJTS9Uc043Y2pRbTVXbGxjUHduQy9l?=
 =?utf-8?B?QXI1Wi9MZnR0Z2I4d21RU2lIR2lPc241SElGWnQyYlBYSU9ob2MyVjlaTXp5?=
 =?utf-8?B?Z1pIQXROY0wxdjArSlFQOGd5cWhlcm5oT3BoYjRhRnhFV2lDZ2hXemRzcERa?=
 =?utf-8?B?anpXN0pQZjhUdHJSYmdEeE9wdmZiSGNSbFBtY1IrUUtxYTBkK1lxbGFSODBW?=
 =?utf-8?B?endEcyt2LzRObHNTSFNmam53UFJxdGMzSm1iOE9leStwUXJEdVVVd3ozSGVr?=
 =?utf-8?B?WitoTGZ3NDNVbWtTOENrcUo2ajRSU1BkVUdCMURucnpnczRxb3prRDFnNHVZ?=
 =?utf-8?B?eDBGQTUvUGExc0dBM0oydDU1QUV3K2Vlbmh2eVZmWmZzcjk3WlF0Y3FBL1c3?=
 =?utf-8?B?VHV3dWFIZVMrdkI4dkRtVDVEVmtSbVFKZmJzWldDNE9XRklna3E2NWtnQ3J1?=
 =?utf-8?B?OFdHVEI5NW5mdXQxazlZQnFIWTlBbTZoUlBoWitWZE5Rc1JqV1VxUmJ2NDc4?=
 =?utf-8?B?SkVZVTZwN0VXM0hPMDdRN01Ld3FpZEdMa3Bhc0VMa3Nkd3JzbVgydGR3OExQ?=
 =?utf-8?B?VE5OaEJuYmhoRldydHNndUVjUWlxK1Bjb21PTHA3WjAvN3Q3dlgrcE9EUDVQ?=
 =?utf-8?B?aXhMb09mNUUxK2dGMzQ1RXlXTXNTL1llVzN6VzdpNFc3ZDNLZGRvUytUSHp4?=
 =?utf-8?B?ZWEzYjNiVmIxOC9QOHp1Q0JGYlZGOVd3RzVaaFVBMG8zYmhaWjBLR0t5Zlhm?=
 =?utf-8?Q?2BzM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d829d98d-bbf5-4609-d80e-08dbb37a9d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:25:40.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfsMyocd+kdMTBnAg/Cy6YmLHPBOLwjS/PORhQKpn8eAoyGSxPDReLUgq572llU2vEihkRa9ZzD/mJretNQu5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAzOjQ3IFBNDQo+IA0KPiBPbiA5LzEyLzIwMjMg
NToyOCBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIs
IDIwMjMgMjozNiBQTSBJZiB5b3Ugd2FudCBBUSB1c2VkIGZvciBMTSwNCj4gPj4gaXQgc2hvdWxk
IHN1cHBvcnQgbmVzdGVkIGFueXdheSwgZG9uJ3QgYnJlYWsgdXNlciBsb2dpYy4NCj4gPiBZb3Ug
aWdub3JlZCB0aGUgb3RoZXIgcGFydCBvZiBteSBxdWVzdGlvbiB3aGVuIHlvdSBhc2tlZCBhYm92
ZS4NCj4gPiBpLmUuIGEgUENJIHRyYW5zcG9ydCBkbyBub3QgYWxsb3cgc3VjaCB3ZWlyZCBiaWZ1
cmNhdGlvbi4NCj4gSSBmYWlsZWQgdG8gcHJvY2VzcyB5b3VyIGNvbW1lbnQuIA0KDQo+IERvIHlv
dSBtZWFuIHRoZSByZWdpc3RlcnMgZG9uJ3Qgc3VwcG9ydCBuZXN0ZWQ/DQpOby4gSSBtZWFuIHJl
Z2lzdGVycyBhY2Nlc3Mgc2hvdWxkIHN1cHBvcnQgZGV2aWNlIHJlc2V0IGZsb3cgYW5kIEZMUiBm
bG93Lg0KDQo+ID4+DQoNCj4gPj4gVGhpcyAobXkpc2VyaWVzIGNhbiBzdXBwb3J0IG5lc3RlZC4N
Cj4gPiBNYXliZSBpdCBkb2VzLCB3aXRoIGhhY2tpbmcgdGhlIGRldmljZSByZXNldCBhbmQgRkxS
IHNlcXVlbmNlLCB3aXRob3V0IGRpcnR5DQo+IHRyYWNraW5nLCB3aXRob3V0IFAyUCBzdXBwb3J0
LCB3aXRob3V0IHBhc3N0aHJvdWdoIG1vZGUuDQo+ID4gQWxsIHRoZXNlIHJlcXVpcmVtZW50cyBh
cmUgbm90IGFkZHJlc3NlZC4NCj4gPg0KPiA+IElmIHlvdSBpbnRlbnQgdG8gY292ZXIgYm90aCBy
ZXF1aXJlbWVudHMsIGxldHMgd29yayB0b3dhcmRzIGl0IHRvIHNlZQ0KPiA+IGlmIGl0IGNhbiBj
b252ZXJnZSwgaWYgdGhlcmUgYXJlIHRlY2huaWNhbCBjaGFsbGVuZ2VzLCB0aGVuIHRoZXJlIGlz
IG5vIHBvaW50IGluDQo+IHB1c2hpbmcgdG8gY2xhaW0gdGhhdCBpbi1iYW5kIFZGIHdpdGggbWVk
aWF0aW9uIGlzIHRoZSBvbmx5IHdheSB0byBtb3ZlDQo+IGZvcndhcmQuDQo+IFdoeSBkbyB5b3Ug
bmVlZCBQMlA/IA0KSSBhbnN3ZXJlZCB0aGlzIGJlZm9yZSBmZXcgaG91cnMgYmFjay4NCg0KPiBX
aHkgRkxSIGFuZCByZXNldCBhcmUgY29uY2VybmVkPyANCkJlY2F1c2UgdGhleSBtdXN0IHdvcmsu
DQo+IFdoeSBkbyB5b3UgdGhpbmsgZGlydHkgcGFnZSB0cmFja2luZyBpcyBub3Qgc3VwcG9ydGVk
Pw0KQmVjYXVzZSB5b3Ugd3JvdGUgaW4gY292ZXIgbGV0dGVyICIgRnV0dXJlIHdvcms6IGRpcnR5
IHBhZ2UgdHJhY2tpbmcgYW5kIGluLWZsaWdodCBkZXNjcmlwdG9ycy4iDQpBbmQgeW91IHJlcGVh
dGVkbHkgcmVzaXN0ZWQgYWRtaW5pc3RyYXRpb24gY29tbWFuZHMuIEkgZG9u4oCZdCBzZWUgaG93
IGFib3ZlIHR3byBjYW4gYmUgZG9uZSBlZmZpY2llbnRseSB3aXRob3V0IGFkbWluaXN0cmF0aW9u
IGNvbW1hbmRzLg0KQW5kIGlmIG9uZSBpcyBnb2luZyB0byB1c2UgYWRtaW5pc3RyYXRpb24gY29t
bWFuZCBpbiBmdXR1cmUgZm9yIGFib3ZlIHR3bywgdGhlcmUgaXMgbm8gcG9pbnQgb2YgZG9pbmcg
Y3VycmVudCBzZXJpZXMgb3ZlciByZWdpc3RlcnMuDQpJIGRvbuKAmXQgc2VlIGhvdyBhbmQgYWRt
aW5pc3RyYXRpb24gcXVldWUgY2FuIHdvcmsgYWZ0ZXIgZGV2aWNlIGlzIHN1c3BlbmRlZCwgYW5k
IGFmdGVyIEZMUiBob3cgZGlydHkgcGFnZSB0cmFja2luZyBjYW4gY29udGludWUuDQoNCkFsbCB0
aGVzZSBhc3BlY3RzIGFyZSBjb3ZlcmVkIGluIFsxXSB0aGF0IGNhbiBiZSBleHRlbmRlZCBmb3Ig
bmVzdGluZyBpZiBuZWVkZWQgd2l0aCBzaWRlIGNhciBWRi4NCg0KWzFdIGh0dHBzOi8vbGlzdHMu
b2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMzA5L21zZzAwMDYxLmh0
bWwNCg==

