Return-Path: <virtio-dev-return-13687-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A96DCA0EC9
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:51:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE4F2120D58
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:51:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E0829864B9
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:51:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 90BC29864A5; Tue, 12 Sep 2023 05:51:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A2A8986485;
	Tue, 12 Sep 2023 05:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAYjLRy0dZxjvL34elvOLgri9o2ydvmo1ebXaFQRat8lOFumF7Mhdf10zhR1phZWHbZt6DkxQ3jTHvTKMH7dl13WuEObg9+9Cs1jImagn6V7KsudqU2TZb2UM1MBZ320XDgEfWxLbWyLN5mrj23HhfEIwbZaOqPDAhP5/5f3QSL95tTMgoVO4CXtFKcpXGTkQIocDJBebsujP3M7DNjq/fmBIKWf27ZA+Nq1foNd65J20JJ+1kyoWdALJ/NMKw4ekp5+LeHX8MsDoI5pwyNVvy+AocuWPLdIsOytwQU7vsOrqgqlQAEeANp5cVl1VODZg+HOIcTQkKe/65FDjfFBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWMp3am2ODsVa5O3/YNUr6ozr8FYu34+u/fkwlR3EkY=;
 b=QaPDatQeRdWajFcKjgozkI7XXzkEXGBw8E0wQw6qQNhDE4aHuiKOcF1nYu6DLM4BuXc2hH49gE9PBVHTMljW1DcLbP6juVachduWK9vqhD5W1l+cJl1yS83WFlfQ6F4cAElDiXvutcgN+x352ET2ghMfpBx4kaDFt5TB+kzEEwWe6vHY/jadqr0jG6Rht7psZ35LUdXJ0I5Lq+IKUPWLATz+5ihwYmHku9qY0eI7mjgnKKCuz8mPdsWJHJtJZK0JNdMG0bjIyKnQatCJQKGM/y3tfk9N9nrlLFD2MAqCvRTke+Hgdp3yzaFT1e1V42Y/Ut+y3NP95lh2KcdpZIFxlQ==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQ
Date: Tue, 12 Sep 2023 05:51:27 +0000
Message-ID:
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To: <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7370:EE_
x-ms-office365-filtering-correlation-id: e63e2178-08b8-4a8d-31b2-08dbb3544e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KNyqPLAUYI//Wn1jRCA46oQdk0ygV7llkGrRw0JpHGC1tN40sP/F83UYcgnHpSLDumIbGUJIqUvqjOs/gRamP8GXVgmJbV1ktltDGYfhWoK23XL4WcAio2QuNlfrPbmTMFppnXg8war5I6J1weenWydIdF8UDRAk51fLePQsx6qEOXXOwUhM+jdOTaiIJ3FHBYUIrTe95/P7VTRMaGM08+DvwHRDYGFNlJHotK1215G5nE5SO0wGG8cgVuA0DDljGvqRBUO8D3+jrJfoDGSVRD8QXs3Qrr5uhSkF81sW3GSSnWERiufH1xdV4/Zy84IBzdxWcrkSCi1Z3ZYUFxLjF8VnwJwnkudTd1l3CCv9DR3G2yJEO3yIjYH7BsKw6F322E2agH8MrJDvHa+0Yprfy/plZ1ARffQgTeAnIhRk3cL32wkdOfzsBqGjtGm5tQR8DS4s1Rlu3W9xWGUnAlpAeINEaWuvhl2E+Pnqmahq+51WxcYMPvWi6ZQoCtua7yFGIkZPoYNdzVC++ScNk3GWoO2IitgBUfGVPT1D4koMW8aloED3vWlajjnPDHLWSn92bAVAZDT/bcTRNNWodhW83KmVoqiilBXwvlHn/JkjgexaiHMbuOSsfhZ+xplT8Ro0IO95GflrXsix49qo92/ifCqUHl9b8f5APTUf/AAHgFY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199024)(1800799009)(186009)(55016003)(52536014)(8676002)(54906003)(4326008)(66446008)(66556008)(66946007)(8936002)(41300700001)(2906002)(316002)(110136005)(5660300002)(76116006)(64756008)(66476007)(53546011)(966005)(7696005)(9686003)(71200400001)(38100700002)(6506007)(38070700005)(122000001)(26005)(83380400001)(86362001)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmI1TGtFVWZmU2hTWURxZy9kdFFqNThVZ21LU1FTMFFKWnk4Tjcxd0FlUjRE?=
 =?utf-8?B?UFF2V0VEZFNaU3FJUnJmeEg0UWZGd2Y4RXFsVFJWVUhmWnE0aUw0dC93UEFk?=
 =?utf-8?B?ekk4V29ZUHJUdEZ3UHZGdGpMYksxWnJkQ1E4SDF0YmFLOXJCYklGcVEzNk5U?=
 =?utf-8?B?bkpTK0srNkJVSXdYOU9LVk5lbWVsS1JPZHNSVkRIcnVScDJXcHE5eWZBc3ZW?=
 =?utf-8?B?ZFdHMUhLdVpOYStVTXZZeXJObFNPaFQ1NDBaR0RiT1BuUUhHQ0l3ZnVuZ01a?=
 =?utf-8?B?UnRHVFhyYkZ0RkVTcFQ4aTNtS3RQVFZZL1hRYW5qdXV0MHhLZzVvN0EvV3Y2?=
 =?utf-8?B?clEwRHQrbktwWEtmWk52ZWFMOUx1alEzMldZTGZveUNlS3lxYnVnaWlVSE5E?=
 =?utf-8?B?Zm81bzBEN1kwSCtjTGZvYUl5eFh3emFlTTFlM1MxUHZrVmgwQk9GMDFWdWVu?=
 =?utf-8?B?STRSWW9XREtlb1VnNEJtZTZ2ajZONTFrTUpqNVk5aG41TndiUTZ2ZkFxeG05?=
 =?utf-8?B?SnVrNHY1ZlVXSUJXdCtQMmo4YzBNdnBTN21xVktTMHhNSkdPbVNUYjJzZDNQ?=
 =?utf-8?B?bElRZ0d1NHRUWFVpZ1o1WkhWaVVLZDVDK3JOYkM2dnMranFOM3NYSlZvOUth?=
 =?utf-8?B?WUVRUWNUZFBkRnowRVhjZHhaUW1iMjhTZWNDY1dYT3lXRVNFVmJNS0IyYXFJ?=
 =?utf-8?B?enNmMTBWdnZvUEJxK0xlMEdYQm9EakhFK1MzZENlelpUY3ViYkRnWnhOMi9l?=
 =?utf-8?B?NHJPd0RYZE5GTjRhL0JxeDFJTEtSZlBEUkwvaExJZ1RkRVUvZ1VORzgwOSt0?=
 =?utf-8?B?YmViWHpOZnQwUXp3YVd3b2JFTmhtbWJKMkVkaUlIaUVPUW9BVWFMcUpZQVli?=
 =?utf-8?B?clFWcVJwb2dLQWVCSURtZDVzL29zQnB2NUt5eGUyWmg2RWhBeWlxNlZUekts?=
 =?utf-8?B?NksyTnU2NW1waEpIa3RJbmNSb0NxeFNBSi8vNXhIYjZZZHlsOGlpSEFiN2Ew?=
 =?utf-8?B?NWFhenpXQ2w3YStZcEs0Sk9xbGdZZTdlNWt5TUtLQ2NWRTR2VG1aTnhRNmk4?=
 =?utf-8?B?cWY0S1Q4M3lKWUR3Z3FMK0w2aVR5YzZHOCtES0x6QVZnNWJ2UGI0VnFlMzZG?=
 =?utf-8?B?ZEI0eHZtc3BkL0cybnF1V3ZORk1aekZKQ2JWN2tLdkp0VDVIQ1BnVzh6c0hH?=
 =?utf-8?B?bmhUWlRrODdrbU1PckllZnZJa3kyWG9lUUFUSnpqM1grbC9Pa1JnVGxrWWlM?=
 =?utf-8?B?L2YzRHdQamovRWZlVXRjQUlvaWYrdC9ITVdtd0tseWU3eEI2Zi9aQUl3NFk5?=
 =?utf-8?B?cUtMUnEvOXRGTW9paEVzdGpuOUx4WHdKM1hIenBPM1B3Q1ZoQzh5Yks1M25z?=
 =?utf-8?B?TXlVbjVFcndNUHZnRXVCdGxnQ2tPYW5jZ3lOZHYyRDNtZ1doL1JoaTRqUGMv?=
 =?utf-8?B?TE5uSmZtWXozUGw2cVY0SFJUZlBVNHNZZ3NNbUt6RGRwYm5VV1l5MVZFQWYr?=
 =?utf-8?B?VnhJZWp4MVVtZ2lwS084YmhZMW0valNKOGxoQWg2UnpQbnJvd21VVGVqNGth?=
 =?utf-8?B?ajBqd0VoMC9WUURkRCtKbXhUdmJ5VXc4bEMySEtxc0NuQmpiVCt2Zm41NmxN?=
 =?utf-8?B?eTJaeUJsV25TK0tPU1h5RGJtcUk5dUZIeHVrOXU0RVAyY2NXWFR0T250SmdJ?=
 =?utf-8?B?UFdkRlN4RmlNSG8zcndCdmNsQlBpRDg2VjJNUTk2bHFFWXc2TWYzbXRTUnlD?=
 =?utf-8?B?LzFJZlczaUZveXlhVnZRS3d6NVc1NEc1TW9uUlJIeDZvcEtrckd1MG5vZjZY?=
 =?utf-8?B?MzAwSUFySGlZcFZnaVFCNHZORm1sZ1I2RUlvMjcraUIrc0JmTmFGTklnWUgy?=
 =?utf-8?B?M2tvUzc0YXpTRmZKQk94RnFCcE5GWjJEREZMeVplbWpvNHdBS1Y3bUFVaVNT?=
 =?utf-8?B?OWU3U1cvOEg2eWJQMHVYSFRhM2dmOWFQczVLdEhDNktkekNzVXpmenNnRm03?=
 =?utf-8?B?THlGNkJ5RkZRU3VTak1US2FmL3BXdUx4czlFK2ZyVC90M0Nnc1pmdHpXZCt2?=
 =?utf-8?B?d1V6ekdtN1VZSElPdG5CRWE1Y1FINTNIamxKU3lsRVdzOXJELzdGQ25IVVhk?=
 =?utf-8?Q?2VUs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63e2178-08b8-4a8d-31b2-08dbb3544e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 05:51:27.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGC5ON0FEOhHyNu+tADjMHTZMIUKB7rAENDH5mepoBJ+PHg/9hxSL2peHJ8MSBUnrscS1oLzpeVkMTnF1PmCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyA5OjE5IEFNDQo+IA0KPiBPbiA5LzExLzIwMjMg
Nzo1MCBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwg
MjAyMyAzOjAzIFBNIEJ5IHRoZSB3YXksIGRvIHlvdSBzZWUNCj4gPj4gYW55dGhpbmcgd2UgbmVl
ZCB0byBpbXByb3ZlIGluIHRoaXMgc2VyaWVzPw0KPiA+IEFkbWluIGNvbW1hbmRzIGZvciBwYXNz
dGhyb3VnaCBkZXZpY2VzIG9mIFsxXSBpcyBjb21wcmVoZW5zaXZlIHByb3Bvc2FsDQo+IGNvdmVy
aW5nIGFsbCB0aGUgYXNwZWN0cy4NCj4gPg0KPiA+IFRvIG1lIFsxXSBpcyBzdXBlcnNldCB3b3Jr
IHRoYXQgY292ZXJzIGFsbCBuZWVkZWQgZnVuY3Rpb25hbGl0eSBhbmQgZG93bnRpbWUNCj4gYXNw
ZWN0cy4NCj4gPg0KPiA+IEkgcGxhbiB0byBpbXByb3ZlIFsxXSB3aXRoIHYxIHRoaXMgd2VlayBi
eSBleHRlbmRpbmcgZGV2aWNlIGNvbnRleHQgYW5kDQo+IGFkZHJlc3Npbmcgb3RoZXIgcmV2aWV3
IGNvbW1lbnRzLg0KPiA+DQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9y
Zy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDkvbXNnMDAwNjEuaA0KPiA+IHRtbA0KPiBJ
IGFtIG5vdCBzdXJlLCB3ZSBoYXZlIGRpc2N1c3NlZCBhIGxvdCBhYm91dCB0aGUgcG90ZW50aWFs
IGlzc3VlcyBpbiB0aGUgdHJlYWRzLiBJDQo+IGd1ZXNzIHdlIHNob3VsZCByZXNvbHZlIHRoZW0g
Zmlyc3QuIEUuZy4sIG5lc3RlZCB1c2UgY2FzZXMuDQpZb3UgYXJlIHVzaW5nIG5lc3RpbmcgdXNl
IGNhc2UgYXMgdGhlIF9vbmx5XyB1c2UgY2FzZSBhbmQgYXR0ZW1wdCB0byBzdGVlciB1c2luZyB0
aGF0Lg0KTm90IHJpZ2h0Lg0KDQpJZiB5b3Ugd2FudCB0byBkaXNjdXNzLCB0aGVuIGxldHMgaGF2
ZSBib3RoIHRoZSB1c2UgY2FzZXMsIGF0dGVtcHQgdG8gY29udmVyZ2UgYW5kIGlmIHdlIGNhbiBp
dHMgcmVhbGx5IGdvb2QuDQpJZiB3ZSBjYW5ub3QsIGJvdGggcmVxdWlyZW1lbnRzIHNob3VsZCBi
ZSBoYW5kbGVkIGRpZmZlcmVudGx5Lg0K

