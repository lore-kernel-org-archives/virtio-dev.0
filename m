Return-Path: <virtio-dev-return-13665-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2882EE801F
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:07:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EF6867B166
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:07:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E764E986490
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:07:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5EEC981BDD; Mon, 11 Sep 2023 07:07:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3AA698635C;
	Mon, 11 Sep 2023 07:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd4rau+VM439YLllKURL0FGErIwNo1xhLd35dfxBDKnv6gyD4N58j4CBLf90cEhT/zX3LK60K8MVyAfJoj2L+3Isg5ovK56sDljAapyGURhHpfwlTElybb0RvhQnHgZZtnjtrvpIoz+T1QrB6FLCFwSigNMRSsoxa7sYMMdiFtf5vqb8TsUXOMSkCpIpkEI1RHoT6W5/pffW8hbVTNfN9NyrDbRh6XXBFH4NJxrFR+D0Q1Hh2aTwawkbYlWuBIgq+Isczu2DfQN3xgoET1bqGvtaWepQ8paELAUq/5IItbtMU6+8z5e+opyPsk0/XuZbiRoNKMEhL8OXFuXUq06x6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOMbWHpPQcHGFdFYEksaobZbeLJGUiSCB+/Du+MKT8g=;
 b=Fgdos+ZBfxvs+wwOjiUByk7GuH9YENpSyltrV2biN7b5fecW5qCY2Qd/0jnJ6IyjSMPywZ7XP4HHZpftON/pYjOlKKUhLJzFQhuuqzi3HF8yF68flzTdiHTrOlaD4hLiucfmtVaPRu0SXJ41RpFP05Vea1MffgJSUHooOGSDgLWiKkV1ebVZXm8/sOIB57fjyhnCncd5Tic0kCmAKRwmHlbZXQg2iyZZ0hYbxgMtvJB1FebJOXNZKlffW//c0TOqwsFmfMVCG58DLfJoxdArBtIWe4r0c8z/ZIKKrkgxg/ZSH+ThNo3Ar/cbgm2SWTy+lkJohj/goCyT0YttdzfZYg==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUA==
Date: Mon, 11 Sep 2023 07:07:50 +0000
Message-ID:
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
In-Reply-To: <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB8743:EE_
x-ms-office365-filtering-correlation-id: a43aed28-6e4e-4e3e-d6ba-08dbb295cfc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AJV7OW/oBfPbD9L+SUSZBYT8UIW1eUgqe91wD0QsKkdmgPynkr3Icrki3l8mBAJF0Ar03LYYJuTdNl9rGGj0ew1VMAi60tDhKeHYH6yJi6jLIBzt+zRDYcTHet/40rgDiY4eoxlKmJ/moZ3LrsLLSAsE2FvR4LDvaITU+EELabZ+uxawmRZDtV1rr4V7pj8nirn6V5VzPBc1LySBzl9f3Wc+S6rLB9ksn71rManxyf4HDRfyfVpYpg7czlwzZIoqY7ybGQ+ib5eusuJV6dyHXTo6f2JXP7hT13SBT7xjAo2pIHJ+L9r1/TxK8o5Iq+9s1AdlWd+paeE+5pz8ERPd+FTRBBxjuibIbw4zdG2Mst5ZmXF+bVXYuWJDkXXJB3WNEi2qbW1Y39cTeYIv8Wemr5Il1VTMN1Ck49Bx1JfpNFeCd/2TvjCoS2wJaF1WYvttlR3FAFuheQgSuqX+VhPg9lqG4vKzJ968xrDhkBbb4KZ7vqICxcYciK5yaDcFLZgHv2ch/YfKU4gm8Iwx8xwqCjx0TP5dcuFvFL2+3V0O7CoxLBZEyhn21vUbq9b2U8pr6J6VsVb9L0Yl4p2TzDCtZZ62I4CcfkvsWCgScdpB8JbdwusFoemrhSAoRYeuaK3Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199024)(186009)(1800799009)(38070700005)(33656002)(86362001)(38100700002)(55016003)(52536014)(478600001)(6506007)(64756008)(316002)(110136005)(54906003)(66946007)(76116006)(66556008)(66446008)(66476007)(7696005)(8936002)(4326008)(41300700001)(9686003)(8676002)(5660300002)(122000001)(2906002)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0pxTUt1VE40ZlVkTHh6TUdyMTYrK0xucGpzU2h5eUtKSkVBREhGMWlTWWNN?=
 =?utf-8?B?YWk5cStXSmRNb3QxTmZHY2VlcllzT3lQeCt2NjVKeWVjTVQ5U3g2U1dQTThR?=
 =?utf-8?B?bk8vWnFYTjJSM004RFVoekdLZXBudjh4MEl6Qm91L3lOdnZwZkhYclhxZFg2?=
 =?utf-8?B?b2RUWTB0RFRyZitRS1EreDBZajREeCtUd2lDbmFNKzlwY3N1NURBTUlmS3JH?=
 =?utf-8?B?Qm1kRXZWWDZtVHNVbldCMUJGYW1HUjU0TEZLaGVPYjZTU29iZm5xT1pSUSto?=
 =?utf-8?B?NUVSQ2lSN1hBK1AwbUh6b3M3ZERockdrM2ZZZjR3YTRSQmxMbEw1WDBZbHRV?=
 =?utf-8?B?TkZHa0hPcUJxNWpCMkVTVitqbnYxblBxUUE1OVg5VksrTkk5WDRUYllsNW5x?=
 =?utf-8?B?NXVMY3N5dVk5Tmt5a09Pbi8zbE02STk4WDg2V3Q0Uk9ManlVa2UveVdCcFR5?=
 =?utf-8?B?ODJ2QnZIUDdBa3lwbmRsU0VaRU9DYUtNRnVEcnJGUjBhRFZ0ald4eE5OOUVy?=
 =?utf-8?B?T0xXd2hZUlhTTVVsMUtPc2lTL3dLOU5sdkVHM1Z6L3RmZlJZaDREaUdaY1gr?=
 =?utf-8?B?Sk5WcjMwdXUxcndGQnFCL2VCaFU4Nm1zdUNhek0xUjNSZ1BjRkxPcjFtZE10?=
 =?utf-8?B?b1VJOHY3bHdYTjBWOGRUcmV0Q2JiWDJ2cU5ST2tKL1dXOERERVhUKzZRZHhS?=
 =?utf-8?B?bDU2aG9wZ2owTk5vRjVYR0xFSjNqMlovUnVaSzh3cGlFSDNWT1VoZWhmczgx?=
 =?utf-8?B?UjVYT1gxRTZoaS9pYm1YRDZETVE2NWcwTzAxUndWUVlpdFhSYXI3NXJzdXJE?=
 =?utf-8?B?RkFBa0Y3SWNZczNPNS9RendRbndRNVlTWFJyd3pVa3pSOGxiRkNGUkNHYjdq?=
 =?utf-8?B?RHVXM1E0OHMrZzA5VmlxMU4xdE5OVndTMSsybGtqVEZidGdLOFArYkJTZU10?=
 =?utf-8?B?Mkl6Z2VSeWhGaEFYbWJLQ1FBVWVWRUFYWTBDUWpWejZXUDFSM3lEOFphMnEz?=
 =?utf-8?B?bHFpL1BYTFF0NUl0ZkE0cisrc1E3M1FFMVFxR1Q3djlSYVJsTUZkMm9TOTdS?=
 =?utf-8?B?ZmFZekkvelNmbDY3eDkyMXZ0aG4yRGdKSHpXUks4dDZJSlZ5Q1pKQ0JEYS93?=
 =?utf-8?B?Vm51WkhXY0taOFVJc1JuTEZBbmxFODZySWFIc3lQWHBXZkgrd0Mzbm53K3pE?=
 =?utf-8?B?VFdUYm04dkVtWHZscll2bmpQZGpPMVNFK0cyZFZsZjNVVVJOcUJFYVhod0Ew?=
 =?utf-8?B?TTErUWZZRTFlZ0VEdlJxbEJmVk12RUgzS0grb043QWtrSm11czdCQWhzZkJF?=
 =?utf-8?B?V2ZublRUZEsxTEpJclVrUFpQajgwRlRsNVdGZEZrRkNRNlh4aEREZkJLU2xo?=
 =?utf-8?B?QjRjUHBSZndMdTFwdW9RYVVPaFhKOEpQUGszNHB0aVBNSG9UK1pGMXV2VG8w?=
 =?utf-8?B?Wk5oRGpvWmVCaHkrdHFZY0lYWDRmSG11VzM4THNyZ1Q4TzZIQ3Jhc1hIa3Nv?=
 =?utf-8?B?WDg1QW5ZYkdLM25VYkdPYWNFblh3WXNaaUtBR05CVkJVY0wxNjByWmU1ck84?=
 =?utf-8?B?cFk4SHVrOCszSElwZFN4MWU4NWV5cjE0NXY3cUxKUjVxTXB1c2xzTFFrKzFI?=
 =?utf-8?B?UGUxd0paSG43M24vQ2xya3RlTkVjSFhWeTgwNldrRUNqMkRjQk5oNHhpRkI3?=
 =?utf-8?B?NEsxOTh6dEVDeXU4T1dpekFpS29uZzY4U2lxemRseGwxOW1pQnA1TFFsQlh0?=
 =?utf-8?B?czdtNjB6dk4vbWIrS0c4Y1FUNlFEdytJSUtxSkRhREI0a21lbnliZVpYd1RL?=
 =?utf-8?B?eEtkMDhVMU4yTzVDOVJyWXJEazRML0NIbzZmd2RWUkwwTGNjRFQ2TkNyV05Z?=
 =?utf-8?B?c2VIenlaK2FCaE4yTVFxN2h3aFRJQ0tyamEzalY1ZHBYZUxGWTRwc3QwNDl2?=
 =?utf-8?B?TXpKR0FXZW4xTWFrSW9SaTJxNzlOVk5lOUFnWXRnS0p2a0FHTkNoYVpwNGxx?=
 =?utf-8?B?Myt2UGMzQ3lXWk9KK0MxUUFJY25KbWx4Y1RvRXNWMWx4UGwzb0pITVk2V3dk?=
 =?utf-8?B?Wm9vbHRETVRVZW9OcHNUYjF3TnVRVGd4Sk1yZ0dyNVVqRnRsN2UyY3pkd1ZT?=
 =?utf-8?B?aEtmWDdjRWtON2F3a0RyOG05dWtxbnROZGVxd0JPandhVUNISXNHVWhuc3Fy?=
 =?utf-8?Q?5r4NjFrwyj9yXyWZWVvQ6pc9cynBvktELPWs01KZ0iPN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43aed28-6e4e-4e3e-d6ba-08dbb295cfc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:07:50.8735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRB7uvPW0o/2NoK8Uite8TQHXZoAbSkyyhCZON03/WdrWVRe0nfJHp/CsXk+J2uz6h4cihKkdb76cNxShC+g2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjMgMTI6MjggUE0NCg0KPiA+IEkgZG9u4oCZdCBz
ZWUgaW4gaGlzIHByb3Bvc2FsIGhvdyBhbGwgdGhlIGZlYXR1cmVzIGFuZCBmdW5jdGlvbmFsaXR5
IHN1cHBvcnRlZCBpcw0KPiBhY2hpZXZlZC4NCj4gSSB3aWxsIGluY2x1ZGUgaW4tZmxpZ2h0IGRl
c2NyaXB0b3IgdHJhY2tlciBhbmQgZGlyeS1wYWdlIHRyYWtpbmcgaW4gVjIsIGFueXRoaW5nDQo+
IGVsc2UgbWlzc2VkPw0KPiBJdCBjYW4gbWlncmF0ZSB0aGUgZGV2aWNlIGl0c2VsZiwgd2h5IGRv
bid0IHlvdSB0aGluayBzbywgY2FuIHlvdSBuYW1lIHNvbWUNCj4gaXNzdWVzIHdlIGNhbiB3b3Jr
IG9uIGZvciBpbXByb3ZlbWVudHM/DQoNCkkgd291bGQgbGlrZSB0byBzZWUgYSBwcm9wb3NhbCBz
aW1pbGFyIHRvIFsxXSB0aGF0IGNhbiB3b3JrIHdpdGhvdXQgbWVkaWF0aW9uIGluIGNhc2UgaWYg
eW91IHdhbnQgdG8gY29tYmluZSB0d28gdXNlIGNhc2VzIHVuZGVyIG9uZS4NCkVsc2UsIEkgZG9u
4oCZdCBzZWUgYSBuZWVkIHRvIG1lcmdlIHR3byB0aGluZ3MuDQoNCkRpcnR5IHBhZ2UgdHJhY2tp
bmcsIHBlZXIgdG8gcGVlciwgZG93bnRpbWUsIG5vLW1lZGlhdGlvbiwgZmxycyBhbGwgYXJlIGNv
dmVyZWQgaW4gWzFdIGZvciBwYXNzdGhyb3VnaCBjYXNlcy4NCg0KPiBJZiB5b3Ugd2FudCB0byBp
bXBsZW1lbnQgTE0gYnkgYWRtaW4gdnEsIHRoZSBmYWNpbGl0aWVzIGluIG15IHNlcmllcyBjYW4g
YmUgcmUtDQo+IHVzZWQuIEUuZy4sIGZvcndhcmQgeW91ciBzdXNwZW5kIHRvIFNVU1BFTkQgYml0
Lg0KSnVzdCBWUSBzdXNwZW5kIGlzIG5vdCBlbm91Z2guLi4NCg0KPiA+DQo+ID4NCj4gPj4+IEFk
bWluIHF1ZXVlIG9mIHRoZSBtZW1iZXIgZGV2aWNlIGlzIG1pZ3JhdGVkIGxpa2UgYW55IG90aGVy
IHF1ZXVlDQo+ID4+PiB1c2luZw0KPiA+PiBhYm92ZSBbMV0uDQo+ID4+Pj4gMikgd29uJ3Qgd29y
ayBpbiB0aGUgbmVzdGVkIGVudmlyb25tZW50LCBvciB3ZSBuZWVkIGNvbXBsaWNhdGVkDQo+ID4+
Pj4gU1ItSU9WIGVtdWxhdGlvbiBpbiBvcmRlciB0byB3b3JrDQo+ID4+Pj4NCj4gPj4+Pj4gUG9r
aW5nIGF0IHRoZSBkZXZpY2UgZnJvbSB0aGUgZHJpdmVyIHRvIG1pZ3JhdGUgaXQgaXMgbm90IGdv
aW5nIHRvDQo+ID4+Pj4+IHdvcmsgaWYgdGhlIGRyaXZlciBsaXZlcyB3aXRoaW4gZ3Vlc3QuDQo+
ID4+Pj4gVGhpcyBpcyBieSBkZXNpZ24gdG8gYWxsb3cgbGl2ZSBtaWdyYXRpb24gdG8gd29yayBp
biB0aGUgbmVzdGVkIGxheWVyLg0KPiA+Pj4+IEFuZCBpdCdzIHRoZSB3YXkgd2UndmUgdXNlZCBm
b3IgQ1BVIGFuZCBNTVUuIEFueXRoaW5nIG1heSB2aXJ0aW8NCj4gPj4+PiBkaWZmZXJlbnQgaGVy
ZT8NCj4gPj4+IE5lc3RlZCBhbmQgbm9uLW5lc3RlZCB1c2UgY2FzZXMgbGlrZWx5IGNhbm5vdCBi
ZSBhZGRyZXNzZWQgYnkgc2luZ2xlDQo+ID4+IHNvbHV0aW9uL2ludGVyZmFjZS4NCj4gPj4NCj4g
Pj4gSSB0aGluayBMaW5nIFNoYW4ncyBwcm9wb3NhbCBhZGRyZXNzZWQgdGhlbSBib3RoLg0KPiA+
Pg0KPiA+IEkgZG9u4oCZdCBzZWUgaG93IGFsbCBhYm92ZSBwb2ludHMgYXJlIGNvdmVyZWQuDQo+
IFdoeT8NCj4gDQo+IA0KPiBBbmQgaG93IGRvIHlvdSBtaWdyYXRlIG5lc3RlZCBWTXMgYnkgYWRt
aW4gdnE/DQo+DQpIeXBlcnZpc29yID0gbGV2ZWwgMS4NClZNID0gbGV2ZWwgMi4NCk5lc3RlZCBW
TSA9IGxldmVsIDMuDQpWTSBvZiBsZXZlbCAyIHRvIHRha2UgY2FyZSBvZiBtaWdyYXRpbmcgbGV2
ZWwgMyBjb21wb3NlZCBkZXZpY2UgdXNpbmcgaXRzIHN3IGNvbXBvc2l0aW9uIG9yIG1heSBiZSB1
c2luZyBzb21lIGtpbmQgb2YgbWVkaWF0aW9uIHRoYXQgeW91IHByb3Bvc2VkLg0KDQo+IEhvdyBt
YW55IGFkbWluIHZxcyBhbmQgdGhlIGJhbmR3aWR0aCBhcmUgcmVzZXJ2ZWQgZm9yIG1pZ3JhdGUg
YWxsIFZNcz8NCj4NCkl0IGRvZXMgbm90IG1hdHRlciBiZWNhdXNlIG51bWJlciBvZiBBUXMgaXMg
Y29uZmlndXJhYmxlIHRoYXQgZGV2aWNlIGFuZCBkcml2ZXIgY2FuIGRlY2lkZSB0byB1c2UuDQpJ
IGFtIG5vdCBzdXJlIHdoaWNoIEJXIGFyZSB0YWxraW5nIGFib3V0Lg0KVGhlcmUgYXJlIG1hbnkg
QlcgaW4gcGxhY2UgdGhhdCBvbmUgY2FuIHJlZ3VsYXRlLCBhdCBuZXR3b3JrIGxldmVsLCBwY2kg
bGV2ZWwsIFZNIGxldmVsIGV0Yy4NCg0KPiBSZW1lbWJlciBDU1AgbWlncmF0ZXMgYWxsIFZNcyBv
biBhIGhvc3QgZm9yIHBvd2Vyc2F2aW5nIG9yIHVwZ3JhZGUuDQpJIGFtIG5vdCBzdXJlIHdoeSB0
aGUgbWlncmF0aW9uIHJlYXNvbiBoYXMgYW55IGluZmx1ZW5jZSBvbiB0aGUgZGVzaWduLg0KDQpU
aGUgQ1NQcyB0aGF0IHdlIGhhZCBkaXNjdXNzZWQsIGNhcmUgZm9yIHBlcmZvcm1hbmNlIG1vcmUg
YW5kIGhlbmNlIHByZWZlcnMgcGFzc3Rocm91Z2ggaW5zdGVhZCBvciBtZWRpYXRpb24gYW5kIGRv
buKAmXQgc2VlbSB0byBiZSBkb2luZyBhbnkgbmVzdGluZy4gDQpDUFUgZG9lc250IGhhdmUgc3Vw
cG9ydCBmb3IgMyBsZXZlbCBvZiBwYWdlIHRhYmxlIG5lc3RpbmcgZWl0aGVyLg0KSSBhZ3JlZSB0
aGF0IHRoZXJlIGNvdWxkIGJlIG90aGVyIHVzZXJzIHdobyBjYXJlIGZvciBuZXN0ZWQgZnVuY3Rp
b25hbGl0eS4NCg0KQW55IHdheXMsIG5lc3RpbmcgYW5kIG5vbi1uZXN0aW5nIGFyZSB0d28gZGlm
ZmVyZW50IHJlcXVpcmVtZW50cy4NCg==

