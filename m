Return-Path: <virtio-dev-return-12651-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ECCC77B7F
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:30:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 93ECE11A8B
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:30:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8125F9866D7
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:30:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 720219865E3; Thu, 11 May 2023 13:30:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CD7F9865DB;
	Thu, 11 May 2023 13:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZoo8IYCf3bfNWLej2ENHXRk1ZXy0p/EY35d0XCoAOpcNAO6uUA9/ZdJS2EtaPYnioAF0E3kSYQo5wKPSLsbQLutyZbKqCKz3ZT0ZEK4Ve9ma2O60Pm79kWVP2p73A8qwy7H0GpWLmUM/krzYo3eyue6w6PhzyOVqrDVxbWIqiVgvINBw9nAcoctfqAg564WvyCdywwWdupDnRj6Wj8Mz8lvK9iUlNg6e4XMr2YKtWfy6W9rn/jVRBncshW0/NX1HgShZ4CO8k/m7EQg3NsfSWm3Kgf7zt364E60a2ySY0Dk1vH3HRLf02hg16YCaI6RJndcPutgdoYIunJg+iszoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg6YmjsmS1H00LiPZaC/ofqTSsdvmImhsztwIZAiRRM=;
 b=OTsHdRIZNeQ4TUwkyc2RjyLKhoQhr5RYid1IPZbMwyuZ3VRXtL5zxTKnpNvN86uI4ju47XGz6+PKUcZ4LxegDFjj/ZoaWtPbW5XqxqQeUIGLrvKa5QaCv+OngaCEVKm1qj4elyBxA2EfogmG/uRQrw7lx0eAgU2YpXMiYMNUCsOa32OjgYhCLb4NRzVawc5CdvIJtiuesBZv5W9Ixk8mJRnJDV/sMpL5T4+p9xJ6u++FJHhStDb9Kly/kGjUY9C0125Aeo1/O2vX06K/G9mJ8TndNli/GsCLTqM2wXA9SLU9hBhIocMjCOpIpw65hLyHgvYbHAzcNi7dzwD9jhGTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQ
Date: Thu, 11 May 2023 13:28:40 +0000
Message-ID:
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
In-Reply-To:
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6880:EE_
x-ms-office365-filtering-correlation-id: 44be6f75-858c-42ae-bcad-08db5223a23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EElZaCr+uPNxizPPu+R3bfavL84U50ZxfyTx0EHB/v1257ITvg1QSGw75f/r7k71fMev3p2ITevdmKmJYCwQbZX8bIeQ+44XZEWJpEqdRxHXLx6yhzIxMXo2/j9HkxkNI/hzV6C0dykJY5k7AAl+/LuqRnFDpPMbDE41/c8LeWNbAQOiRdJSjr3AOFaFe+WXb6dFcjiW+VnfuF0aPnbQEf7nEurXKmxgyGfn77uIwMeVI5pxvQ906qDBdjw90zV8YwKr3xab8E2cEsDHGLg26v/lsYoRrW0VjAWK9tdx2uJvJJeTqLzwXuNLCunZh8MAeUrPzcZmMHtgTZlLy6YXcYT3ockB66JMx2IaAfhHkk2X510FL1wxPzOL8ZM6PyNiSdYasAHdqfPOlZDFzWfreztH/NcXibgmU6QSlEyC9vjVoikhMqGQSGFt4Anna1nxz/fBb5bBocY8yU0Q1Sr0cQTFG+HPi5t8v34pwHPTIJEtsPOz0YPBigrpSmFKndm2yhtBIuAsrvg2rECFqt0iNhXMQsXRhaB3PEepoGqByXxJ+XLPHN9cE1CHz/usXnimYsOdocKbSaQwHi5D+bg0vpsG2v8IkTBoBfzwaV3S6qBzRHNQPI5Q8wcGecq15WvvdiFMW8q7LfAz5P2t+p9UV4mGmVJQx1Hc4oBJqvR70gw6V22RmwPIWlAv1ZNcDAJ9g3wd0VQY65tvg612FT8jqQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(8676002)(4326008)(478600001)(8936002)(316002)(64756008)(5660300002)(66446008)(66556008)(6916009)(66476007)(54906003)(2906002)(41300700001)(71200400001)(76116006)(52536014)(66946007)(7696005)(107886003)(966005)(9686003)(26005)(6506007)(186003)(83380400001)(55016003)(38100700002)(38070700005)(86362001)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDZhbFY0K0EzUElmV2VtclRLenIrQ1hURHhmbXM2cW4ra2RydUF3VXVick1O?=
 =?utf-8?B?N3RFQm9jUS9teGIvUWtOYk94TnBSb0dKdHNOUkl6SEZHVDEreUc5TmhLUmRw?=
 =?utf-8?B?OFd1eTFWemNyN0pTWEUxejl2UndiQk1VMzE5TUVHWTR1OWxReGQ5bUJYQm9w?=
 =?utf-8?B?SVpuaTZvVExlVVd3WXJqZGlQWWV2Qzl3aFVhK2EvNnFvajNjaGtwd3l4OHlS?=
 =?utf-8?B?SFJJMmhoYmFTUjlrMk9XYTRnU1hzdUl3ZXhIL1M2bUEvcnJVb1FnWEh0OWVv?=
 =?utf-8?B?R3RUZEdxdnplc1NRZ2NMbjNoSUdEYTIydEQ2dW5ubEFESUt3Zk5vTVhDZ1Jw?=
 =?utf-8?B?Y1hoUnFqcnc4b25RbEZhSFI0N0p5ZEZDcXVieHJKYkxmRlprajJpamhRN3lB?=
 =?utf-8?B?ekNGUUhtY05tT1hTZHJoOHZWb2tWU3VyMjhNSkd0MEladVc3VzBrejVWZ3d0?=
 =?utf-8?B?ayt4UmlIZGpHdWZDQUt2M3ptSzIzS2o5bDZDaElBSXlxdHFDSXN1alEzWW1K?=
 =?utf-8?B?V3AzSUx0dHFuNVcvazJSbWdqTjA4Qk91S3k1UktJTkVZOWJUR1Y1Sy9ONitn?=
 =?utf-8?B?T0JDVHB2bGtZb3A4QnMzOGlsZk1mU1ZaN3kzOWVNTTA4K2M1OUpmSGdZdkRR?=
 =?utf-8?B?d1hBTlpseGgrTm4va0hYYll4T2ZxS1YxalBZdjFiVENIeGE5RHcxMnByTG4z?=
 =?utf-8?B?bXdsUld3TTRaYXVaNWN5Ymd5ZVhUOFlKbUpPeW5hTFdpSllkeml1Ulc0QklM?=
 =?utf-8?B?VHEvaTRLbjVZc3JqbXhYNXlnclRBNUwzQ3BsN0RtRGhUc1BvbWRWZmpzQjJr?=
 =?utf-8?B?WU83RFViMXFPK1Z0TEE3UmVjVWNXL3NEbXYzWVNrVHhnR0NuYVNScFZwSkQ4?=
 =?utf-8?B?WDA1dHB1ZW1uTXV1TUUzNWFoc0I1YTNTZk1oNk9YaysxZGRJUnpDOXlVS0cx?=
 =?utf-8?B?amIvbzRoSUlhK25NRnU3WTZTMEhxMmZGd08weWppSkRtYjczN3VBQWxLbGZS?=
 =?utf-8?B?aHRNTkZRY0laOWIwWGUyZ01PMjBEVHFzY05PQ0ttRzFXZjVSUHNOeEdGbzA5?=
 =?utf-8?B?TGlLTHBYSUJHWXUyQ01CMmZ4NzlkVDBROXdBeGFublZvNlh4dnZ2eVQ0VzN3?=
 =?utf-8?B?R0E5Q1BNdnM0RVJvVGsrV1J3bUJBWjVxeDVSQmtYRDZjcWdUSkRCV0N3VERC?=
 =?utf-8?B?dVl3MjF3M0tvdVBZVTRRVk9NWU91VmFiMWZ5OTlsU25kZTBIcWFyZDI0c3RI?=
 =?utf-8?B?MDBLUDA3YzVZdTNpRHVJU092RytPa3p5UTJLQWZrOUE5emFPdGJISW5ma0JQ?=
 =?utf-8?B?SklieVErdEVId2I2alo0YlVEWTFhVVFhY3lxZnVidWNiWGVCRlFjcE1qUlR4?=
 =?utf-8?B?d3lFUHpVb3NZTUw4L0xQeHVFbHNkWGFka2VnMWlsQkZGVXo5M3JhZm15YUdZ?=
 =?utf-8?B?b3JEMVlEdm1CSHdKRThXVDVpNDJrZmd1dU9UNjkwOE1TamNjTzcvZ2c3cm5G?=
 =?utf-8?B?MUIrRlFsMHhoVEh6ei9rVWFiVk1KbTRxNW4xVHdhdWhrZkxHN2JTQlMrWVBk?=
 =?utf-8?B?YU45Q2hKR3JBbXd5YmZpVUgxSDBxdUNNR2FTK0p4a1VEbk1zcnhrcjkyUjl5?=
 =?utf-8?B?bXZhT01RcjFvYm4rSDN6Z1ZYL2lMblZiNVYwNHpCY1NpRno5QUZHT1RkSHJP?=
 =?utf-8?B?QloxT1ZBN3Jqc0tzRXgyQm12d1kwMngwM01OVUlTYnhkcXVhekhUKzAzeThv?=
 =?utf-8?B?VUoyZmJYa3A5L2JJSkZxZFBDV0JjOUQ0amtHcElTMmdmUWw1K0JSVkxnZVYv?=
 =?utf-8?B?akNpdnBiNnVGaGZmNE05ZXNuU2xTTmcvZXArdTdXeExvVXN0WUpqeUw3ZVRy?=
 =?utf-8?B?SFVTR2JLNEIwa2VHbzlyV3k1dXBLc0d1MVBESDhUZ2VrRFlnRDNuNnEweGhP?=
 =?utf-8?B?WE5naFppME9ZQysxSkxKNG82Q2RlRzNmdTNIb2VVazVsR1JpT09idTRENDFM?=
 =?utf-8?B?NHVZallYSkdpclgzUmFscHdMdm03QUVlc09WTGhuVzE5bk5uRVg3RnQ4N3lZ?=
 =?utf-8?B?MTZvS2lPdVhTZlRtNDlZS0ZBaWFXWXJaY3JGRzFMRW03bGVJQmVnc0IwYmtk?=
 =?utf-8?Q?vays=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44be6f75-858c-42ae-bcad-08db5223a23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 13:28:40.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDNHOsuPWx8JE/kvr5EKaq8jy2EXw/OsqB5gIoF221I1jeKXPVSubfConzsazOEcc54WMhpmuTOIQ0LK12Y/Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIE1heSAxMSwgMjAyMyAzOjA3IEFNDQoNCj4gPiA+IDR0aCBwb2ludCBpbiBjb3ZlciBs
ZXR0ZXIgaXM6ICJjb25maWcgdmlydHF1ZXVlcyBvZiB0aGUgbWFuYWdlZCBkZXZpY2UiLg0KPiA+
ID4NCj4gPiA+IFRoaXMgd29yayBiZWxvbmdzIHRvIHRoZSBkcml2ZXIgLT4gZGV2aWNlIGRpcmVj
dCBjb21tdW5pY2F0aW9uIHVzaW5nDQo+ID4gPiBhIHF1ZXVlIGZyb20gZHJpdmVyIHRvIGRldmlj
ZS4NCj4gPiA+IFNvLCBJIGltYWdpbmUgdGhpcyB3b3JrIGNhbiBiZSBkb25lIHVzaW5nIGEgcXVl
dWUgYnkgdGhlIGd1ZXN0DQo+ID4gPiBkcml2ZXIgYW5kIHNlcnZpY2VkIGJ5IHRoZSBkZXZpY2Ug
bGlrZSBob3cgYSBndWVzdCBkcml2ZXIgY29uZmlndXJlcw0KPiA+ID4gdGhlIHF1ZXVlIHRvZGF5
IHdpdGhvdXQgYW55IG1lZGlhdGlvbi4NCj4gPiA+IEZvciBQQ0ksIE1NSU8gdHJhbnNwb3J0LCBz
dXJlbHkgdGhpcyBjYW4gYmUgZG9uZSBieSB0aGUgUENJIGRldmljZQ0KPiA+ID4gZGlyZWN0bHkg
YmVpbmcgaXMgUEYsIFZGIG9yIFNJT1YuDQo+ID4gPiAoSW5zdGVhZCBvZiBjb25maWcgcmVnaXN0
ZXIsIHVzaW5nIGEgbmV3IHF1ZXVlIGludGVyZmFjZSkuIExvb2tzIGZpbmUgdG8gbWUuDQo+IA0K
PiBHcmVhdC4NCj4gDQo+ID4gPg0KPiA+ID4gQ2FuIHRoaXMgbmV3IGNmZyBxdWV1ZSBtZWRpYXRl
ZCBsaWtlIENWUSB0aGF0IGlzIGRvbmUgaW4gYSBzdz8gTWF5IGJlIHllcy4NCj4gPiA+IFNob3Vs
ZCBpdCBiZSBhbHdheXMgbWVkaWF0ZWQgd2hlbiBpdCBpcyBvZiBWRiwgU0lPViBEZXZpY2U/IE1v
c3RseQ0KPiA+ID4gbm8gYmVjYXVzZSBpdCBpcyB5ZXQgYW5vdGhlciBWUSBmb3IgUEYsIFZGLCBT
SU9WLg0KPiANCj4gWWVzLCB0aGUgbWVkaWF0aW9uIGlzIGFsd2F5cyBjb25kaXRpb25hbCBidXQg
bm90IG1hbmRhdGVkIHdoZW4gZG9pbmcgdGhlDQo+IGRlc2lnbi4NCj4gDQo+ID4gPg0KPiA+ID4g
SSBhbSB5ZXQgdG8gcGFyc2UgcmVzdCBvZiB0aGUgNCBwYXRjaGVzLCBwbGVhc2UgZ2l2ZSBtZSBz
b21lIHRpbWUgdG8gcmV2aWV3DQo+IGl0Lg0KPiA+DQo+ID4gSSB3ZW50IG92ZXIgdGhlIHBhc3Qg
d29yayBvZiBbMV0sIFsyXS4NCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIyMDgyNjEwMDAzNC4yMDA0MzItMi1saW5nc2hhbi56aHVAaW50ZWwNCj4gPiAu
Y29tLyBbMl0NCj4gPiBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRp
by1jb21tZW50LzIwMjIwOC9tc2cwMDE0MS5oDQo+ID4gdG1sDQo+ID4NCj4gPiBUaGUgInZpcnRp
byBxIGFzIHRyYW5zcG9ydCIgaW4gWzJdIGlzIGJpdCBtaXNsZWFkaW5nIGFzIGl0cyBvbmx5IHJv
bGUgaXMgdG8NCj4gdHJhbnNwb3J0IHRoZSBfcmVnaXN0ZXJzXyBvZiB0aGUgU0lPVl9SMSBkZXZp
Y2UgdGhyb3VnaCBpdHMgcGFyZW50IFBGLg0KPiA+IFJlc3Qgb2YgdGhlIHdvcmsgaXMgdGhlIHB1
cmUgbWFuYWdlbWVudCB3b3JrIHRvIG1hbmFnZSB0aGUgbGlmZSBjeWNsZSBvZg0KPiBTSU9WIGRl
dmljZXMgKGNyZWF0ZS9kZWxldGUvY29uZmlndXJlL2NvbXBvc2UpLg0KPiANCj4gSSB0aGluayB0
aGlzIGNhbiBiZSB0d2Vha2VkIGZvciBzdGF0aWMgcHJvdmlzaW9uaW5nIHNldHVwcyBsaWtlIFNS
LUlPVi4gRS5nIGdyb3VwDQo+IG93bmVyIGNhbiBjaG9vc2UgdG8gbm90IGFkdmVydGlzZSB0aGUg
bGlmZSBjeWNsZSBtYW5hZ2VtZW50IGNvbW1hbmRzLiBUaGVuDQo+IHRoZSBoeXBlcnZpc29yIG1h
eSBrbm93IHRoZSBwcm92aXNpb25pbmcgaXMgdHJhbnNwb3J0IHNwZWNpZmljLg0KPiANCkl0IGlz
IGp1c3QgYnVuY2ggb2YgYWRtaW4gY29tbWFuZHMgaW4gdGhlIG5ldyBTSU9WIG9yIHZpcnR1YWwg
dmlydGlvIGRldmljZSBjaGFwdGVyLg0KSXQgaXMgbm90IGEgdHJhbnNwb3J0IGNoYXB0ZXIuDQoN
Cj4gPg0KPiA+IEFuZCB0aGUgbW90aXZhdGlvbiBpcyBhbHNvIGNsZWFyIGlzIHRvIHByb3ZpZGUg
Y29tcG9zaW5nIGEgdmlydGlvIGRldmljZSBmb3IgdGhlDQo+IGd1ZXN0IFZNIGZvciB0aGUgYmFj
a3dhcmQgY29tcGF0aWJpbGl0eSBmb3IgMS54IHBhcnQgb2YgdGhlIHNwZWNpZmljYXRpb24uDQo+
ID4NCj4gPiBJdCBzZWVtcyBmaW5lIGFuZCBpbmRlZWQgb3J0aG9nb25hbCB0byBtZSB0aGF0OiBp
dCBpcyBmb3IgYmFja3dhcmQNCj4gY29tcGF0aWJpbGl0eSBmb3IgYWxyZWFkeSBkZWZpbmVkIGNv
bmZpZyBmaWVsZHMgZm9yIGV4aXN0aW5nIGd1ZXN0IFZNIGRyaXZlci4NCj4gPg0KPiA+IEl0IGRv
ZXMgbm90IGNvbmZsaWN0IHdpdGggdGhlIGNmZ3EvY21kcSBpZGVhIHdob3NlIG1haW4gcHVycG9z
ZSBpcyBmb3IgdGhlDQo+IG5ldyBjb25maWcgZmllbGRzLCBuZXcgdXNlIGNhc2VzIHRoYXQgZG9l
c24ndCByZXF1aXJlIGFueSBtZWRpYXRpb24uDQo+ID4gU3VjaCBjZmdxIHdvcmtzIGFjcm9zcyBQ
RiwgVkYsIFNGL1NJT1YgZGV2aWNlcyBpbiB1bmlmb3JtIHdheSB3aXRob3V0DQo+IG1lZGlhdGlv
bi4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgY2ZncS9jbWRxIGNvdWxkIGJl
IGRvbmUgb24gdG9wLCBzaW5jZSB0aGUNCj4gY29tbWFuZHMgYXJlIHBhcnQgb2YgdHJhbnNwb3J0
IHVubGVzcyBJIG1pc3Mgc29tZXRoaW5nLg0KPiANCk9uIHRvcCBvZiB3aGF0Pw0KY2ZncS9jbWRx
IGlzIGp1c3QgYW5vdGhlciBxdWV1ZSBsaWtlIGFueSBvdGhlciBWUS4NCml0IGlzIG9ydGhvZ29u
YWwgdG8gYWNjZXNzaW5nIDEueCByZWdpc3RlcnMgdXNpbmcgZ3JvdXAgb3duZXIncyBxdWV1ZS4N
Cg0KPiA+IEl0IGFsc28gc2NhbGVzIGRldmljZSByZWdpc3RlciBtZW1vcnkgYWxzbyB2ZXJ5IHdl
bGwgaW4gcHJlZGljdGFibGUgd2F5Lg0KPiA+DQo+ID4gVGhlIHJlZ2lzdGVycyBhbmQgZmVhdHVy
ZSBiaXRzIGFjY2VzcyBkZXNjcmliZWQgaW4gWzJdLCBjYW4gY2VydGFpbmx5IGJlIGRvbmUNCj4g
dXNpbmcgbmV3IG5vbl9sZWdhY3kgbmV3IEFRIGNvbW1hbmRzLg0KPiA+IEJvdGggbGVnYWN5IGFu
ZCBub24tbGVnYWN5IGNvbW1hbmQgaGF2ZSBkaWZmZXJlbnQgc2VtYW50aWNzIGFzIE1pY2hhZWwN
Cj4gbWVudGlvbmVkLg0KPiA+DQo+ID4gVGhlIEFRIHNlbWFudGljcyB0aGF0IE1pY2hhZWwgZGlk
IGFzIG9wcG9zZWQgdG8gInZpcnRxdWV1ZSBhcyB0cmFuc3BvcnQiIGZpdHMNCj4gd2VsbCBmb3Ig
dGhlIHVzZSBjYXNlIGRlc2NyaWJlZCBpbiBbMV0uDQo+ID4NCj4gPiBUaGVyZSBhcmUgY2hhbmdl
cyBvbiBnb2luZyBpbiBNU0ktWCBhcmVhIGFuZCBTSU9WLCBzbyB5b3UgbWlnaHQgd2FudCB0bw0K
PiB3YWl0IGZvciBpdC4NCj4gDQo+IEkgdGhpbmsgeW91IG1lYW50IElNUywgYWN0dWFsbHksIGl0
J3Mgbm90IGhhcmQgdG8gYWRkIG5ldyBjb21tYW5kcyB0byBzdXBwb3J0DQo+IGEgZ2VuZXJhbCBJ
TVMuIFdlIGNhbiBzdGFydCBmcm9tIGEgdmlydGlvIHNwZWNpZmljIG9uZSAoYXMgaXQgbG9va3Mg
YSBjb21tb24NCj4gcmVxdWlyZW1lbnQgbm90IG9ubHkgZm9yIFBDSS9TSU9WIGJ1dCBhbHNvIGZv
ciB0cmFuc3BvcnQgbGlrZSBNTUlPKQ0KPiANCklNUyBjb25maWd1cmF0aW9uIHVzdWFsbHkgc3Vw
cG9zZWQgdG8gZ28gZGlyZWN0bHkgdG8gdGhlIGRldmljZS4gTG9uZyBkaXNjdXNzaW9uIHdpdGgg
VGhvbWFzIG9uIElNUyB0b3BpYy4NCkkgd2lsbCBhdm9pZCBkaXZlcnRpbmcgdG8gdW5yZWxhdGVk
IGRpc2N1c3Npb24gZm9yIG5vdy4NCg0KPiA+IE9yIHByb3Bvc2VkIGNvbW1hbmQgaW4gWzFdIHNo
b3VsZCBiZSB0YWdnZWQgYXMgc2lvdl9yMSwgdGhlbiB0aGluZ3Mgd2lsbCBiZQ0KPiBjbGVhbmVy
Lg0KPiANCj4gTWF5YmUgd2UgY2FuIHNheSwgb25lIG9mIHRoZSBpbXBsZW1lbnRhdGlvbnMgaXMg
c2lvdl9yMSwgc2luY2UgaXQgY2FuIGJlIHVzZWQNCj4gdG8gaW1wbGVtZW50IGRldmljZXMgaW4g
b3RoZXIgdHJhbnNwb3J0LiBPbmUgb2YgdGhlIG1haW4gbW90aXZhdGlvbnMgZm9yDQo+IHRyYW5z
cG9ydCB2aXJ0cXVldWUgaXMgdG8gcmVkdWNlIHRoZSB0cmFuc3BvcnQgc3BlY2lmaWMgcmVzb3Vy
Y2VzIHRvIGVhc2UgdGhlDQo+IHZpcnRpbyBkZXZpY2UgaW1wbGVtZW50YXRpb24uDQo+IA0KWWVz
LCB0aGUgbWFpbiBtb3RpdmF0aW9uIGFzIGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGZvciB0
aGUgY3VycmVudGx5IGRlZmluZWQgZmVhdHVyZXMuDQoNCj4gPg0KPiA+IFdpdGggdGhhdCBJIGRv
bid0IHNlZSBsZWdhY3kgMyBjb21tYW5kcyBhbnl3YXkgY29uZmxpY3Qgd2l0aCBbMV0uDQo+IA0K
PiBJdCBkb2Vzbid0LCBidXQgaXQncyBub3QgZWxlZ2FudCBzaW5jZToNCj4gDQpJIGRvbuKAmXQg
c2VlIGhvdyBtYWtpbmcgMyBjb21tYW5kcyB0byA5IGNvbW1hbmRzIG1ha2VzIGl0IGVsZWdhbnQg
YnkgZG9pbmcgYmlzZWN0aW5nIG9mIHJlZ2lzdGVycyBvZmZzZXQgaW4gaHlwZXJ2aXNvci4NCkl0
cyBzYW1lIHRoaW5nIHVzaW5nIG1vcmUgb3Bjb2Rlcy4NCg0KPiAxKSBNb2Rlcm4gdHJhbnNwb3J0
LCBhZG1pbiB2aXJ0cXVldWUgd2l0aCB3ZWxsIGRlZmluZWQgdHJhbnNwb3J0IGNvbW1hbmRzDQo+
IDIpIExlZ2FjeSB0cmFuc3BvcnQsIHdvcmtzIG1vZSBsaWtlIGEgUENJIHRyYW5zcG9ydCBvbiB0
b3Agb2YgdGhlIGFkbWluDQo+IHZpcnRxdWV1ZQ0KPiANCj4gVHJhbnNwb3J0IHZpcnRxdWV1ZSB0
ZW5kIHRvIGJlIHRyYW5zcG9ydCBpbmRlcGVuZGVudCwgYnV0IDIpIHRpZSBpdCBzb21laG93IHRv
DQo+IHRoZSBQQ0kuIFRoYXQncyB3aHkgSSBzdWdnZXN0IHRvDQo+IA0KVGhlIDQgcGF0Y2hlcyBh
cmUgbm90IHRyYW5zcG9ydGluZyBhbGwgdGhlIFBDSSB0aGluZ3Mgb3ZlciB0cmFuc3BvcnQgVlEu
IGl0IGlzIG5vdCBhIHRyYW5zcG9ydC4NCkl0IGlzIG1lZGlhdGlvbiBkb25lIGZvciBTSU9WIGxp
a2UgaG93IGl0J3MgZG9uZSBmb3IgMiBwYXRjaGVzLg0KDQo+IDEpIGludHJvZHVjZSBsZWdhY3kg
dHJhbnNwb3J0IGNvbW1hbmRzDQo+IA0KPiBvcg0KPiANCj4gMikgdHdlYWsgeW91ciBwcm9wb3Nh
bCB0byBiZWNvbWUgYSBQQ0kgb3ZlciBhZG1pbiB2aXJ0cXVldWUNCj4gDQpUaGlzIGlzIG5vdCB0
aGUgb2JqZWN0aXZlIHRvIHRyYW5zcG9ydCBhbGwgUENJIHZpcnRpbyBmaWVsZHMgb3ZlciBBUS4N
ClRyYW5zcG9ydCBWUSBjb21tYW5kcyBwcm9wb3NhbCBjb21tYW5kcyBhbmQgY29tbWFuZHMgaW4g
dGhpcyBwcm9wb3NhbCBhcmUganVzdCBmaW5lIHRoZSB3YXkgdGhlcmUgd2l0aG91dCBxdW90aW5n
IGl0IGFzICJ0cmFuc3BvcnQiLg0K

