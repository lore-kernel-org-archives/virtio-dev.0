Return-Path: <virtio-dev-return-13706-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF28CCA0ECE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:21:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2DF262A8E2
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:21:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26CB6986665
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:21:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1B8CC986499; Tue, 12 Sep 2023 09:21:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A38198648C;
	Tue, 12 Sep 2023 09:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wgn2fBM6arv6gpeyACGLdD+Yf0YyYE6MCr1Gp6qMLpCLc1e9XmGL0bXiycYiYyyDph2giGT4DRoTDbm5Rs7f04k+PIn3x06mE4DlBNcOm6CVali4/8+oaf922zM3Ba8Asj0SYYG+cEaMHquFSWQaNdjWVtCOL9b78bjHYPTTH3SHzDkCBxtD9uAkgSQP08pHFndHTKwQmMZgmWaM5RYn/+IHPBB9ZV4ADcO4LosHyA/fy4aCNpAKZGAqba2CM12evk9gmHhbg6ZIODuznXcXre/SUdfJWl9Wy/OiV3q6MRZAjBEPgJ9vHsTA3QtNTc5XN5UmqyEfuSpJjfPQXn+AOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yxD/tsbmgmrzsZdm/dYzPaLy/b+xfCmxTuTUtZVJh4=;
 b=QuKnwcufbWtjxTeJmUA/hz5wzFnB1VfqSxMjdOWh6/dWKvnDeC+gQZuZ/l5BMQKqNlE64CHnE8MgnuuU/D9dEjeo3jdtUkEG616jeoYiXwPzaupR6FP2jQDUvSKakfzwwrowldSMrsO86WN1RoWsnd3gmOL/5pPiA9rZKnBG/WOqdrcXZv6cnZA7JrReNzjpE/3JjFgjijEcdxnkj8LKaAyZBJalgj8GnaTblglgaa2o1HNlRhs43Y/IVcaXtaGs4ENhPcHQzj9hrLFqnhUFL8ikjP9z5vHp6HMbYz8WGB/CbQHhFxfNyvmoCPymzzhckEXnAwr/pQmb9C6J43nVEA==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAI3wCAAS5OAIAAHWKQgAALxgCAAABUEIAADrWAgAAAMqCAABphAIAAAHKA
Date: Tue, 12 Sep 2023 09:21:23 +0000
Message-ID:
 <PH0PR12MB5481678840AE3B1B2D97D512DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E3CC2F6107515F9D7FFEDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
 <PH0PR12MB54815D2BB18E83B8DAFCFBC3DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82805bc3-f891-a35a-12fd-f4799e28570c@intel.com>
 <PH0PR12MB548180A5F840A34DC4DFE334DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <987f72eb-f82c-da4b-229c-ffc5b60d6fb4@intel.com>
 <PH0PR12MB5481F256CCB58C10DB65A8D1DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0861d9ff-d126-c6e4-0deb-74ca81675eeb@intel.com>
In-Reply-To: <0861d9ff-d126-c6e4-0deb-74ca81675eeb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6146:EE_
x-ms-office365-filtering-correlation-id: 6c9a9c71-9e79-43f9-94e6-08dbb371a1fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3wJkWPYvmxy+eaEchCMMSttf8oMpAkbvggzjaSRhl2hlX/k3FUL1bMcLopENBZxCcHQJLmxcSwOZ2srnVP8DSsPKsskYBRC6ktSp/y3L96/WXo49W+tBOb1XxL/jy36ivhOtsW8MSN6iYjSIjWjHUPhoLqZdw/4XDvMPO3AcWWvY3kqaHp/cnkCrHEVFqixeUdMdkKhLEpgsrA5GclsWCkQhsW8JIEfRJwwtyS2RWFP75jZ8+8de3NvgtspAkOKrou62gt3B5kFZbH85VKtYa+SDjJo0IaWtHyrSPsNdKmey47ZgTDLb/U6XdB8S9VUesGQeY14gnKQEkYhYW63IcPCJz4HbV0n10+uV1Lt4g8D+3AVgGG2bNzDSeZUlMsKDPwozKg3UDQFmfb21+Zt/skT41xfZtQqMwPu1YtGkSL8pYoo6syR2Rorm7NOn9+8Nh/7Zfcb5Te6psO8KmnJy3j1wlGySohPNHU81bn1icJZhPdewd726WUKwoIPZpLbvI0UZGwAWLdyTJsrKILibu5Fp7Z8mIHf6JbrMmDXbbGOtGiytw61js6t6k4omAUvMj6agvlzDsski0XWdPxi1vnIuKOKIIT59vOzG65CZCV+j6zLPQJUBioi5kuC9cbgF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199024)(186009)(1800799009)(6506007)(7696005)(9686003)(66899024)(71200400001)(83380400001)(38070700005)(122000001)(33656002)(86362001)(38100700002)(55016003)(26005)(52536014)(316002)(41300700001)(2906002)(76116006)(66946007)(66556008)(4326008)(54906003)(110136005)(66476007)(64756008)(66446008)(8676002)(5660300002)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czloekNNc1BWdjVwVCttMkRBTGMyMmVnWWdsczVYeTJRdGROMkt6R3dSOGVs?=
 =?utf-8?B?d3ZzMVpod0xGUEFSV0dZa3ZGZHBncEF2Z0R5THdOTW9PKzgrVjNvckcwcWQv?=
 =?utf-8?B?N2RYSDF3ZktsREMzRWFUS0IvZzgweFFsNVU4VmZtQVIzOHhBM1VPQ1BhOW5T?=
 =?utf-8?B?QzV6UFFvOWxreitUNjJwV0pyazF6cTFMRmRxaFJ2OG1VMHRXc0E4OWwvc2U4?=
 =?utf-8?B?UWJ2eGRpRTljdHM2MThrK3pXaDdhNmF6RXExNkRTQ3diVk1kSVFOZDhYMmI0?=
 =?utf-8?B?Y3JheVc2Mm1ZK1FQUFVZamtOWG9YbmVPY0o2UGxFRmEzYUVlbVpBekJkSjZ6?=
 =?utf-8?B?UTZSZGUzeU1mSFpkMTc1bFhsSEY3STBFeGV5RncwRW9obnVhcXlBNnlVVGJO?=
 =?utf-8?B?eEtqckdiZUo5UlptZytkV3JKRmRrb3hraDc2R0NMMEYvTUhJVHFOc21nd3J6?=
 =?utf-8?B?MWp2MllZZDJrRWVwYWxIUTJEZVRPWGxQY0tyWFZQVFp2alVOSnRvYXhrMlFl?=
 =?utf-8?B?SUFIVlNadlduVURLd1A3ZEFISklsbWxRS3B5OXZJU25WQUlvWXFjWjl5ZWt0?=
 =?utf-8?B?TDVmYVpTeGswbUd2azk0dGc4dkFBTzdOMnB0K3BHZTZmVXAxNnliU0REV2g3?=
 =?utf-8?B?bGQ0dW1kOWFnVVBJWWErL0Z6ZjhqR2tKREs3dzZVclpESzczcjMyM2JqMlVw?=
 =?utf-8?B?QXdnYi85ejFjMXNWeFJYOU9rSHorVmY2SS9MVmJuRkJOY1Y1SS9PNmNoTVpk?=
 =?utf-8?B?SlgvbUxGVUlDMHRZSjIxNElMY3VYblluOGpSVFdPeVcybkpWUFgwTVFZeHpt?=
 =?utf-8?B?YVQrQzh3Zlh6NmhVZ0taTExpY0x0WlMyMnBDNXFVZHBkOUkxb05qUnpDZVVH?=
 =?utf-8?B?N0xES3Bqc3JXUUJOR3Z3QytadGorajdKK1NNbVBDc2pTcDFjVXhMSTdPRjRW?=
 =?utf-8?B?QWI0WHljSFc3NGJBZzR1enFSMFVFV2dteTAvL2tCWHRvaitRbFBWRnVOVlJH?=
 =?utf-8?B?ZStOaWJNdmtteDFCajMvSGE0V2djU3dkV2IwcHJOZWI0ZTJGaUV2ZkZHejRo?=
 =?utf-8?B?bjV5Vno4MjlQRWMrQi9qR1RJakQrT01WT2I3b0YwQ1Z4S3JWSzlOenY2d3dv?=
 =?utf-8?B?YXhHUUl1NXVFOENrbXFSQ0wvNDNjdnVKYW9McXJ2U0wrdG5hN044UHB1NFpS?=
 =?utf-8?B?TC8wSlhPRkEyL2crYmg5R3haTzV1VFRJUStCQW5FTjhVTHU0WWdjelBXU2NO?=
 =?utf-8?B?T3dvRkJBYTlzRGJRQ2JsVDIrSmFIb2doaHIwU1lHNGlUMlhONXZYTk5kS2xY?=
 =?utf-8?B?UGNOVGpOTUF4T3dZR3FGeTJ2R1RmcmZoK1A3eWd3Wm0xQStCdTN1Q2JvSm16?=
 =?utf-8?B?ZEFyeG5GM0dsSzBIYVcyMGphdzFNUWQyempibFJteUpWUkN2QXFOR25KSkxm?=
 =?utf-8?B?TVVvQmVnS2txc2dMRFFLZFN5WlJhT00wNEY1OFhaa050VHdXRTdnVlo5QzNI?=
 =?utf-8?B?ZTZYMzFXWW1WekFEcVR0Y0luSDQ1RGNPbjhKWTJxaUExUUs5L2RVcGNMZ1ZK?=
 =?utf-8?B?aU1FV0NiN0NCbUZBRnpydWFvQmZiMlhGdjhaMEJnejZFRzIyYlZuTWhJRlU5?=
 =?utf-8?B?eGNBKzRYNktKZG9YVGV3K1YzWDlSWHhBUWF5RENkUEdqQ3VCdzViWlFiZEtu?=
 =?utf-8?B?QUxaN0x5VTVvaGRHM0dMaVFoSkR3dGZGblJvNzRHcHBpcWJydC9SMHlzK004?=
 =?utf-8?B?ZkZVdlQveERpRWhmV1ZJdGhvUHFYQ1NQZzBTWXFNbVdiL3VoaDRFcEdFdm5P?=
 =?utf-8?B?QjE5REd4WnVuT2NpZHMyTzdkT3h2eGhMc2d2azhub3Y5SUowa0Vpd0N1bUVW?=
 =?utf-8?B?ZWpwS3l0bmxTTVRPOU9VanZEQ1YzNmVmeVRaeUxvZnMvVDZKNW05Yyt6dzRn?=
 =?utf-8?B?ZFBkdE9JVEdiSENnZVNRS3k2VUZsMHhuaW93eXFDWGp2aUJVTS91TmZKdDV1?=
 =?utf-8?B?OGhnUXlpNGUwNzROeXlZRXBFblZZajF0S0RLblFoOE9Cc0pzMFpScllodFlV?=
 =?utf-8?B?bmNMSlJpa3JFOUowNjlHUkFyb0RMWVZ2VDUxT2VWcmZMRWhaQTdCTjhpUEZR?=
 =?utf-8?Q?LE0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9a9c71-9e79-43f9-94e6-08dbb371a1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 09:21:23.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K53Bz9uKzbIyVcfDWzFdzZj4b8exVB7ub9smcPZnQJimhKplzHab0Gd/kNfrUAyxcYajI9+h10gKNCBl9C+t+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAyOjMzIFBNDQoNCj4gYWRtaW4gdnEgcmVxdWly
ZSBmaXhlZCBhbmQgZGVkaWNhdGVkIHJlc291cmNlIHRvIHNlcnZlIHRoZSBWTXMsIHRoZSBxdWVz
dGlvbg0KPiBzdGlsbCByZW1haW5zLCBkb2VzIGlzIHNjYWxlIHRvIHNlcnZlciBiaWcgYW1vdW50
IG9mIGRldmljZXMgbWlncmF0aW9uPyBob3cgbWFueQ0KPiBhZG1pbiB2cXMgZG8geW91IG5lZWQg
dG8gc2VydmUgMTAgVk1zLCBob3cgbWFueSBmb3IgMTAwPyBhbmQgc28gb24/IEhvdyB0bw0KPiBz
Y2FsZT8NCj4NClllcywgaXQgc2NhbGVzIHdpdGhpbiB0aGUgQVEgYW5kIGFjcm9zcyBtdWx0aXBs
ZSBBUXMuDQpQbGVhc2UgY29uc3VsdCB5b3VyIGJvYXJkIGRlc2lnbmVycyB0byBrbm93IHN1Y2gg
bGltaXRzIGZvciB5b3VyIGRldmljZS4NCiANCj4gSWYgb25lIGFkbWluIHZxIGNhbiBzZXJ2ZSAx
MDAgVk1zLCBjYW4gaXQgbWlncmF0ZSAxMDAwVk1zIGluIHJlYXNvbmFibGUgdGltZT8NCj4gSWYg
bm90LCBob3cgbWFueSBleGFjdGx5Lg0KPiANClllcywgaXQgY2FuIHNlcnZlIGJvdGggMTAwIGFu
ZCAxMDAwIFZNcyBpbiByZWFzb25hYmxlIHRpbWUuDQoNCj4gDQo+IEFuZCByZWdpc3RlciBkb2Vz
IG5vdCBuZWVkIHRvIHNjYWxlLCBpdCByZXNpZGVzIG9uIHRoZSBWRiBhbmQgb25seSBzZXJ2ZQ0K
PiB0aGUgVkYuDQo+DQpTaW5jZSBpdHMgcGVyIFZGLCBieSBuYXR1cmUgaXQgaXMgbGluZWFybHkg
Z3Jvd2luZyBlbnRpdHkgdGhhdCB0aGUgYm9hcmQgZGVzaWduIG5lZWRzIHRvIHN1cHBvcnQgcmVh
ZCBhbmQgd3JpdGUgd2l0aCBndWFyYW50ZWVkIHRpbWluZy4NCkl0IGNsZWFybHkgc2NhbGVkIHBv
b3IgdGhhbiBxdWV1ZS4NCiANCj4gSXQgZG9lcyBub3QgcmVzaWRlIG9uIHRoZSBQRiB0byBtaWdy
YXRlIHRoZSBWRnMuDQpIZW5jZSBpdCBkb2VzIG5vdCBzY2FsZSBhbmQgY2Fubm90IGRvIHBhcmFs
bGVsIG9wZXJhdGlvbiB3aXRoaW4gdGhlIFZGLCB1bmxlc3MgZWFjaCByZWdpc3RlciBpcyByZXBs
aWNhdGVkLg0KDQpVc2luZyByZWdpc3RlciBvZiBhIHF1ZXVlIGZvciBidWxrIGRhdGEgdHJhbnNm
ZXIgaXMgc29sdmVkIHF1ZXN0aW9uIHdoZW4gdGhlIHZpcnRpbyBzcGVjIHdhcyBib3JuLg0KSSBk
b27igJl0IHNlZSBhIHBvaW50IHRvIGRpc2N1c3MgaXQuDQpTbmlwcGV0IGZyb20gc3BlYzogIiBB
cyBhIGRldmljZSBjYW4gaGF2ZSB6ZXJvIG9yIG1vcmUgdmlydHF1ZXVlcyBmb3IgYnVsayBkYXRh
IHRyYW5zcG9ydCINCg0KPiBWRnMgY29uZmlnIHNwYWNlIGNhbiB1c2UgdGhlIGRldmljZSBkZWRp
Y2F0ZWQgcmVzb3VyY2UgbGlrZSB0aGUgYmFuZHdpZHRoLg0KPg0KPiBmb3IgQVEsIHN0aWxsIHlv
dSBuZWVkIHRvIHJlc2VydmUgcmVzb3VyY2UgYW5kIGhvdyBtdWNoPw0KSXQgZGVwZW5kcyBvbiB5
b3VyIGJvYXJkLCBwbGVhc2UgY29uc3VsdCB5b3VyIGJvYXJkIGRlc2lnbmVyIHRvIGtub3cgZGVw
ZW5kaW5nIG9uIHRoZSBpbXBsZW1lbnRhdGlvbi4NCkZyb20gc3BlYyBwb2ludCBvZiB2aWV3LCBp
dCBzaG91bGQgbm90IGJlIHNhbWUgYXMgYW55IG90aGVyIHZpcnRxdWV1ZS4NCg0KPiA+IE5vLiBJ
IGRvIG5vdCBhZ3JlZS4gSXQgY2FuIGZhaWwgYW5kIHZlcnkgaGFyZCBmb3IgYm9hcmQgZGVzaWdu
ZXJzLg0KPiA+IEFRcyBhcmUgbW9yZSByZWxpYWJsZSB3YXkgdG8gdHJhbnNwb3J0IGJ1bGsgZGF0
YSBpbiBzY2FsYWJsZSBtYW5uZXIgZm9yIHRlbnMNCj4gb2YgbWVtYmVyIGRldmljZXMuDQo+IFJl
YWxseT8gSG93IG9mdGVuIGRvIHlvdSBvYnNlcnZlIHZpcnRpbyBjb25maWcgc3BhY2UgZmFpbD8N
Cg0KT24gSW50ZWwgSWNlbGFrZSBzZXJ2ZXIgd2UgaGF2ZSBzZWVuIGl0IGZhaWxpbmcgd2l0aCAx
MjggVkZzLg0KQW5kIGRldmljZSBuZWVkcyB0byBkbyB2ZXJ5IHdlaXJkIHRoaW5ncyB0byBzdXBw
b3J0IDEwMDArIFZGcyBmb3JldmVyIGV4cGFuZGluZyBjb25maWcgc3BhY2UsIHdoaWNoIGlzIG5v
dCB0aGUgdG9waWMgb2YgdGhpcyBkaXNjdXNzaW9uIGFueXdheS4NCg0KDQo+ID4NCj4gPj4gUGxl
YXNlIGFsbG93IG1lIHRvIHByb3ZpZGUgYW4gZXh0cmVtZSBleGFtcGxlLCBpcyBvbmUgc2luZ2xl
IGFkbWluIHZxDQo+ID4+IGxpbWl0bGVzcywgdGhhdCBjYW4gc2VydmUgaHVuZHJlZHMgdG8gdGhv
dXNhbmRzIG9mIFZNcyBtaWdyYXRpb24/DQo+ID4gSXQgaXMgbGVmdCB0byB0aGUgZGV2aWNlIGlt
cGxlbWVudGF0aW9uLiBKdXN0IGxpa2UgUlNTIGFuZCBtdWx0aSBxdWV1ZSBzdXBwb3J0Pw0KPiA+
IElzIG9uZSBRIGVub3VnaCBmb3IgODAwR2JwcyB0byAxME1icHMgbGluaz8NCj4gPiBBbnN3ZXIg
aXM6IE5vdCB0aGUgc2NvcGUgb2Ygc3BlY2lmaWNhdGlvbiwgc3BlYyBwcm92aWRlIHRoZSBmcmFt
ZXdvcmsgdG8gc2NhbGUNCj4gdGhpcyB3YXksIGJ1dCBub3QgaW1wb3NlIG9uIHRoZSBkZXZpY2Uu
DQo+IEV2ZW4gaWYgbm90IHN1cHBvcnQgUlNTIG9yIE1RLCB0aGUgZGV2aWNlIHN0aWxsIGNhbiB3
b3JrIHdpdGgNCj4gcGVyZm9ybWFuY2Ugb3ZlcmhlYWQsIG5vdCBmYWlsLg0KPg0KX3dvcmtfIGlz
IHN1YmplY3RpdmUuIA0KVGhlIGZpbmFuY2lhbCB0cmFuc2FjdGlvbiAoYXBwbGljYXRpb24pIGZh
aWxlZC4gUGFja2V0ZWQgd29ya2VkLg0KTE0gY29tbWFuZHMgd2VyZSBzdWNjZXNzZnVsLCBidXQg
aXQgd2FzIG5vdCB0aW1lbHkuDQoNClNhbWUgc2FtZS4uDQogDQo+IEluc3VmZmljaWVudCBiYW5k
d2lkdGggJiByZXNvdXJjZSBjYXVzZWQgbGl2ZSBtaWdyYXRpb24gZmFpbCBpcyB0b3RhbGx5DQo+
IGRpZmZlcmVudC4NClZlcnkgYWJzdHJhY3QgcG9pbnQgYW5kIHVucmVsYXRlZCB0byBhZG1pbmlz
dHJhdGlvbiBjb21tYW5kcy4NCg0KPiA+DQo+ID4+IElmIG5vdCwgdHdvIG9yDQo+ID4+IHRocmVl
IG9yIHdoYXQgbnVtYmVyPw0KPiA+IEl0IHJlYWxseSBkb2VzIG5vdCBtYXR0ZXIuIEl0cyB3cm9u
ZyBwb2ludCB0byBkaXNjdXNzIGhlcmUuDQo+ID4gTnVtYmVyIG9mIHF1ZXVlcyBhbmQgY29tbWFu
ZCBleGVjdXRpb24gZGVwZW5kcyBvbiB0aGUgZGV2aWNlDQo+IGltcGxlbWVudGF0aW9uLg0KPiA+
IEEgZmluYW5jaWFsIHRyYW5zYWN0aW9uIGFwcGxpY2F0aW9uIGNhbiB0aW1lb3V0IHdoZW4gYSBk
ZXZpY2UgcXVldWluZyBkZWxheQ0KPiBmb3IgdmlydGlvIG5ldCByeCBxdWV1ZSBpcyBsb25nLg0K
PiA+IEFuZCB3ZSBkb27igJl0IHB1dCBkZXRhaWxzIGFib3V0IHN1Y2ggdGhpbmdzIGluIHNwZWNp
ZmljYXRpb24uDQo+ID4gU3BlYyB0YWtlcyB0aGUgcmVxdWlyZW1lbnRzIGFuZCBwcm92aWRlcyBk
cml2ZXIgZGV2aWNlIGludGVyZmFjZSB0bw0KPiBpbXBsZW1lbnQgYW5kIHNjYWxlLg0KPiA+DQo+
ID4gSSBzdGlsbCBkb27igJl0IGZvbGxvdyB0aGUgbW90aXZhdGlvbiBiZWhpbmQgdGhlIHF1ZXN0
aW9uLg0KPiA+IElzIHlvdXIgcXVlc3Rpb246IEhvdyBtYW55IGFkbWluIHF1ZXVlcyBhcmUgbmVl
ZGVkIHRvIG1pZ3JhdGUgTiBtZW1iZXINCj4gZGV2aWNlcz8gSWYgc28sIGl0IGlzIGltcGxlbWVu
dGF0aW9uIHNwZWNpZmljLg0KPiA+IEl0IGlzIHNpbWlsYXIgdG8gaG93IHN1Y2ggdGhpbmdzIGRl
cGVuZCBvbiBpbXBsZW1lbnRhdGlvbiBmb3IgMzAgdmlydGlvIGRldmljZQ0KPiB0eXBlcy4NCj4g
Pg0KPiA+IEFuZCBpZiBhcmUgaW1wbHlpbmcgdGhhdCBiZWNhdXNlIGl0IGlzIGltcGxlbWVudGF0
aW9uIHNwZWNpZmljLCB0aGF0IGlzIHdoeQ0KPiBhZG1pbmlzdHJhdGlvbiBxdWV1ZSBzaG91bGQg
bm90IGJlIHVzZWQsIGJ1dCBzb21lIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXINCj4gc2hvdWxkIGJl
IHVzZWQuDQo+ID4gVGhhbiB5b3Ugc2hvdWxkIHByb3Bvc2UgYSBjb25maWcgcmVnaXN0ZXIgaW50
ZXJmYWNlIHRvIHBvc3QgdmlydHF1ZXVlDQo+IGRlc2NyaXB0b3JzIHRoYXQgd2F5IGZvciAzMCBk
ZXZpY2UgdHlwZXMhDQo+IGlmIHNvLCBsZWF2ZSBpdCBhcyB1bmRlZmluZWQ/IEEgcG90ZW50aWFs
IHJpc2sgZm9yIGRldmljZSBpbXBsYW50YXRpb24/DQoNCg0KPiBUaGVuIHdoeSBtdXN0IHRoZSBh
ZG1pbiB2cT8NCg0KQmVjYXVzZSBhZG1pbmlzdHJhdGlvbiBjb21tYW5kcyBhbmQgYWRtaW4gdnEg
ZG9lcyBub3QgaW1wb3NlIGRldmljZXMgdG8gaW1wbGVtZW50IHRob3VzYW5kcyBvZiByZWdpc3Rl
cnMgd2hpY2ggbXVzdCBoYXZlIHRpbWUgYm91bmQgY29tcGxldGlvbiBndWFyYW50ZWUuDQpUaGUg
bGFyZ2UgcGFydCBvZiBpbmR1c3RyeSBpbmNsdWRpbmcgU0lPViBkZXZpY2VzIGxlZCBieSBJbnRl
bCBhbmQgb3RoZXJzIGFyZSBtb3ZpbmcgYXdheSBmcm9tIHJlZ2lzdGVyIGFjY2VzcyBtb2RlLg0K
DQpUbyBzdW1tYXJpemUsIGFkbWluaXN0cmF0aW9uIGNvbW1hbmRzIGFuZCBxdWV1ZSBvZmZlciBm
b2xsb3dpbmcgYmVuZWZpdHMuDQoNCjEuIEFiaWxpdHkgdG8gZG8gYnVsayBkYXRhIHRyYW5zZmVy
IGJldHdlZW4gZHJpdmVyIGFuZCBkZXZpY2UNCg0KMi4gQWJpbGl0eSB0byBwYXJhbGxlbGl6ZSB0
aGUgd29yayB3aXRoaW4gZHJpdmVyIGFuZCB3aXRoaW4gZGV2aWNlIHdpdGhpbiBzaW5nbGUgb3Ig
bXVsdGlwbGUgdmlydHF1ZXVlcw0KDQozLiBFbGltaW5hdGVzIGltcGxlbWVudGluZyBQQ0kgcmVh
ZC93cml0ZSBNTUlPIHJlZ2lzdGVycyB3aGljaCBkZW1hbmQgbG93IGxhdGVuY3kgcmVzcG9uc2Ug
aW50ZXJ2YWwNCg0KNC4gQmV0dGVyIHV0aWxpemUgaG9zdCBjcHUgYXMgbm8gb25lIG5lZWRzIHRv
IHBvbGwgb24gdGhlIGRldmljZSByZWdpc3RlciBmb3IgY29tcGxldGlvbg0KDQo1LiBBYmlsaXR5
IHRvIGhhbmRsZSB2YXJpYWJpbGl0eSBpbiBjb21tYW5kIGNvbXBsZXRpb24gYnkgZGV2aWNlIGFu
ZCBhYmlsaXR5IHRvIG5vdGlmeSB0aGUgZHJpdmVyDQoNCklmIHRoaXMgZG9lcyBub3Qgc2F0aXNm
eSB5b3UsIHBsZWFzZSByZWZlciB0byBzb21lIG9mIHRoZSBwYXN0IGVtYWlsIGRpc2N1c3Npb25z
IGR1cmluZyBhZG1pbmlzdHJhdGlvbiB2aXJ0dXF1ZXVlIHRpbWUuDQo=

