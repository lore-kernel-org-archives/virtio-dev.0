Return-Path: <virtio-dev-return-13972-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34962E810AD
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 09:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5ACBB71CA7
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 09:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF4FF9867C4
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 09:20:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 29613986413; Wed, 27 Sep 2023 09:20:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC21998640F;
	Wed, 27 Sep 2023 09:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOkO8K8wT0ORFGQ2CHWfx2niOwtZWPfamz3uNkX9xq+qB0njGosO/lZg7nC0pQvThBhhxIqFmgMxdKAEcvtSYhBN2AMmGg4DO18aBaGs1nJ2DzKAiOu+qAeVfu4WVkaU2DOCL7PIEvRHiAc4Ocria2jxHz5yFgRuoAghhK5tGvz/bWlgOe7fLZlJCb882dqXTo/GI3wv2I1J3SwOigWoVx+pxKrm1Xku7s3TH9RF91iytXtaALXBfqs9xXYUWM1nohjD9KV2DZUHElNDKQe4GhuHfyMmoDiBprmWQhVw4hNkya3ILLfX5Wyowv3uQ0mxG6D0kcwaBsTIfw9yRnNt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOLOvJ3ABsRGzW10rhAsSA2bHAUmXuFi9MdWjS9zOGg=;
 b=HJc8qHfahvMJa6kFLcSaBEuDLwKVa1s6KoDaKtwNDopWDHOhMjTgWjhHgFw+ACqI4XbhYkkJVJ1muizP5NZ7DvmXLDa2GKwvWVzSBQRSDOT3s8EMU/IwunbMPyflaBz6qOqBjNDx1TT57d1HG4cREckE2t49plUAtqZE0+p5Zm4uJ4AOtqfVbk5I2BC1JpgrzsNioFRpXVb17HXg4nIHNToCEmT1l492TaAqaw2i9MC4+TuqPRG+ZE67j/oCPL4KJYlZhfjFA99RjLw1zVUQrGwJENuXCKY1y8rRLsFdXy18DZDaB5QFTgYtqta5CBTia0HPDvGZgWMUl20Dj4YEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, Jason Wang
	<jasowang@redhat.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index:
 AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AksLcAgACjFgCAANz/gIAAzyqAgAPgxwCAAg2+AP//hDuAgAEFWAD//43HgIAB7YYA
Date: Wed, 27 Sep 2023 09:19:23 +0000
Message-ID:
 <BL1PR12MB58498FF5D92D762BC20B763DE7C2A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
 <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
 <BL1PR12MB5849B427B23D1ED269808463E7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtuRwAig_AbMA1YFa9YVw2aBQJDhZ06ZiD_QugthPDROQ@mail.gmail.com>
 <BL1PR12MB584991A9503502EDCB6B9D0BE7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481E765DA98E7AD3D1BED15DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481E765DA98E7AD3D1BED15DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MN2PR12MB3391.namprd12.prod.outlook.com
 (15.20.6863.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BY5PR12MB4870:EE_
x-ms-office365-filtering-correlation-id: e740c8b4-473c-4392-0fec-08dbbf3ad69e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +y4snfb+xg5o/Nkl1WnaueexjZI/+maJvgpsklPtvj+GRm2E8X26nlTOOUGG+LkzMjacLSh+BUFyTInNiPZnwFLZMuiiBZ4SPeVEEuNH8/rbHW5r8xTe7ho71HpoUwI2abM1iJv1gyTiQKyDfHmCz4d5i+VXIZaOo2YQaiZ5Zy420GvkNQP75oCXcuR/Zfz58dJMOVBzFx6lR041AjHaUnLCHSDrNvjOXFw/Spjszh5xDPFRHIC2UX1Na5bv6Ma7rTktfSP5RPC7NobfPAOm8fnnNPsWTHvQatgY9t2rtU7MdBKfNiGI2dU8szg/dIfZdbojwL2vCSLjRv5v+o1BRmuGNYk391NE7uSsMXH0VHQY3N4T5wOaNjeYhx9BSLZVQ+txnRi5W6BjAwNdsDIMqUE7BCZZouvhFGgTycDoNPP91EP5wxKLz0Gm7fMP6fMEbQTjfq519p7qhpkR6Gcj0OVCPimSlBuARgSFEYrNjce8t6s4zaMxIQvxUPBeweh/OebtW6Wf7V5bltBJWifWpfBLgNdVfiW0Y2J1/I0zcojJ7mXisH8GYucpkIlISIT+OlwAbWV8iTgsUWTiXhTWNKmi81jEyMDEVhz7d8/JtaE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(4326008)(8676002)(8936002)(966005)(2906002)(83380400001)(52536014)(66899024)(7696005)(316002)(9686003)(55016003)(53546011)(66446008)(64756008)(54906003)(66556008)(66946007)(66476007)(38070700005)(122000001)(76116006)(6916009)(26005)(38100700002)(41300700001)(7416002)(478600001)(5660300002)(6506007)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnZwOVV4bmdNME9VWERkWjA2NjQwaDFYUWg0N1FDOVZkRzQzNENtNTIvbjhy?=
 =?utf-8?B?NU5qQVZ4b01qWXNvRzhOQlM3SW1qR1VJL0hnRDRRMXk1cE1GelJvRVRMWmR3?=
 =?utf-8?B?Wm5jNml0d0tKZlBDVi9TU1R3Z0o3RENpdDdYTitMamtoWWUrQkxzSHVhTEtt?=
 =?utf-8?B?RTZOeVFEanhOT05FK3VmUXhmWlljZjZjT1JJNE5tYXJsNVdYR3B5cHQ2a1p2?=
 =?utf-8?B?bzdFQS9hb0Y2d2pXTmlDbDlzdTJ2VCsxMG5ITzBTTXdVNUhwNUN0ZnMwdVpI?=
 =?utf-8?B?M0VURk5qcTBISWFKdzQ2enJ2aW0vSFV6WTh1UitvUHZyWkxmOVdPWTlKckp5?=
 =?utf-8?B?dzBpbWtOSUVmSFlYZ1paZjRsTnpDZ3p4OHpVRUVzdUowb3dDL0MzY2J4RDQv?=
 =?utf-8?B?ekRoSUxNM3JYU3dIM2NVRm9oZGNXaTU3UU53NXVnZ2haMmtUZmN2UVJNajc3?=
 =?utf-8?B?VG96NGw4OFdoQlBmU3BSN0RFM08xQy9HRGdVUkx3QzlTNi9BOXl6Mi9wRSt0?=
 =?utf-8?B?YlVIQ1FDRWVBWkpyOVVNZVJmVk5JeExzb1NiTkg5SU9KKytkZnZMSXdIb01s?=
 =?utf-8?B?emdWMmNYbnl4Ly93OTFkYm5NZTZDbjB2M2p4TkNGK2ZVNklLT1FvYmxyQk8z?=
 =?utf-8?B?RkJIbXhKbTRPdlhKZ1dIWS9HMTRFL0x6VDZrQUJzS2IvWGJ6QVdWby9DU2RB?=
 =?utf-8?B?TUxMYkphdCs1dHZTN2VGUkpCQzNlaDNJaE9hQ01vaHZaSndOVS9DaUU0cS9x?=
 =?utf-8?B?RHlBT0FzeitYYjVCYnNWeHUwblJqQmJoWEtBem53RW5XNXpjM2RPTkxjTWJs?=
 =?utf-8?B?N2k0c3R3bmcrMWJGdkNFSUxWeW9qWkM0cXVBbVR2cVk1d3l2dlVzMWVmeWo4?=
 =?utf-8?B?QUtzMWc4Mi9IalY5Wk1MR1JXeEFDZ09CWDFJUlVKMVpFN3NBcXhoV2VmeWY0?=
 =?utf-8?B?b3Jma2VkTWkzRGxENVJhVUZWNCtSK3o2U0FqUHRkV2FPNGowbVR5MGErdkUx?=
 =?utf-8?B?bWo3cTFTaWsvcXdpcTlVZUp1d0NuSDUrZHNqbmY2MFE3cXkxWHd1WlRnMlNG?=
 =?utf-8?B?ZHNHVEtrbGdINTE4bkVPYUFhZ3hWNnltb3FpbkFFdVU3SWhWYzRvSGNtTVBY?=
 =?utf-8?B?RSs4RllSdmxhOStBQnh4Z0VtVjJtbTdjL2NOSHVvQWVWWDBuMG5Rd1NYOFVy?=
 =?utf-8?B?VnBSRzUwUGM0Ni8rWUF4cjA0ajZWRVFuMkZNU0t1Wmt6RWZQRjY5WStYdU1i?=
 =?utf-8?B?M1NXeWZ1NjlBbzlBeEVHSHJsdjBHcWR3Yi9IZWRJNFFwQ09HOGNQcTlsajU4?=
 =?utf-8?B?cDNGM2plc2x6ZDlWYzVyK1dRcjJxM2FLMDRxZ1hDK3M1dEJOR0F1aytoZ2Fq?=
 =?utf-8?B?STkrNnVZa3FWT3ptdlJUYS91WHg2TTh6QVRzY241ZUN6Zk0yVEtKbEJWTnBD?=
 =?utf-8?B?M1hhN09VUDFEbVFaSmdLU0YvNTVzNzN2UjRGYm9KVm1hTlNIN1lPSE1hcDlt?=
 =?utf-8?B?U1hTMEtXdlIvNGpXOFh4MVdDSzhrcWF1YWFPbU0za0g0MFlNcGo1ZXdVQzNl?=
 =?utf-8?B?ampybGxXZ0lnSzIvTDlQRzVwSTFYSFYxRjV2aE5ZZWtneWhRak1ZMldNb2hI?=
 =?utf-8?B?SnY3eTBsZkp5T0ZML3hyQW5Td29XRHJyWnBTYThFTnoxSGo5cUJNS2hwM3VC?=
 =?utf-8?B?dFYrOFhVL0pNT0tGelBWNkR6OFNMSGV0bVlqYXMrT2NkSHdoczJmKzhMbTQ4?=
 =?utf-8?B?d3REYTBiRGNJMUJzRDRQenhWMFNJcnRMbVdMeEluRjdJZVhnKzJ0VlRzTjdM?=
 =?utf-8?B?WEJMRzRVcy9ja0lSeEZUY25RRjFiRk0reFVtZCtjd2M1R1FMdnhNZElPVnpO?=
 =?utf-8?B?Qy9SRU1rVTFFb051anprbU02bVF0RGM3RVp3eE5nbWVEVXhONmp6V1p6Z2dW?=
 =?utf-8?B?eStYU0dsTkxiak1tNFU3c1FsMG5wbVBIUzBRRVdtZHZXb3JsK1ltUWZDbzJ0?=
 =?utf-8?B?Z3J3R21FS1lUQy93N3FtUTNlUW9uN3hFcXpzUi9jZ0pmZUZQSTZIelhGUGZH?=
 =?utf-8?B?SG9EQUs2Rjk1cjZzVjJpSk40d0JOMHBqZU9vWnkzVkZtQy8vT2Exa0ZNZTVn?=
 =?utf-8?Q?9iWE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38A44868DE88784899B2616568D08006@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e740c8b4-473c-4392-0fec-08dbbf3ad69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:19:23.2722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeh3cTi8q9bvg1mmogWOdj0QRZsC40fYlIqErT+J7qD79kOBeTCTihGcwwkxZxSUgatm52p50Q45bj2WXNgIiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

T24gMjAyMy85LzI2IDE5OjM3LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IEhpIEppcWlhbiwNCj4g
DQo+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+PiBTZW50OiBU
dWVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjMgNDozMCBQTQ0KPiANCj4+IEl0IGlzIG5vdCB0byB0
cmlnZ2VyIHJlc3VtZSBiZWhhdmlvciB0byBkZXZpY2UgYnkgc2V0dGluZyB1bmZyZWV6ZSBpbiBt
eSBzY2VuYXJpby4NCj4+IFlvdSBtYXkgbWlzdW5kZXJzdGFuZCBteSBpbnRlbnRpb24uDQo+PiBJ
biBjdXJyZW50IGtlcm5lbCBhbmQgcWVtdSBjb2RlLCBpdCB3aWxsIHRyaWdnZXIgcmVzZXQgZGV2
aWNlIGJlaGF2aW9yIGJ5IHNldHRpbmcNCj4+IGRldmljZV9zdGF0dXMgdG8gMCBkdXJpbmcgcmVz
dW1pbmcsIGFuZCBJIGZvdW5kIHNvbWUgb3BlcmF0aW9ucyBvZiByZXNldCBpcyBub3QNCj4+IHJl
YXNvbmFibGUgZHVyaW5nIHJlc3VtaW5nLCBsaWtlIHZpcnRpb19ncHVfcmVzZXQsIGl0IHdpbGwg
ZGVzdHJveSByZW5kZXINCj4+IHJlc291cmNlcyBhbmQgdGhlbiBjYXVzZWQgdGhlIGRpc3BsYXkg
Z29uZSBhZnRlciBndWVzdCBmaW5pc2hpbmcgcmV1c21pbmcuDQo+IA0KPiBXaGVuIHN1c3BlbmQg
aXMgZG9uZSwgcmVzdW1lIG11c3Qgbm90IGJlIGRvbmUuDQpXaHk/IER1cmluZyBTMywgd2UgZmly
c3RseSBzdXNwZW5kIGd1ZXN0LCBhbmQgdGhlbiByZXN1bWUgZ3Vlc3QsIG5vdCBkbyBzdXNwZW5k
IGFuZCByZXN1bWUgYXQgdGhlIHNhbWUgdGltZS4NCg0KPiBJIGRvbuKAmXQgc2VlIGEgbmVlZCB0
byBtaXggdGhlc2Ugb3BlcmF0aW9ucyBmcm9tIGd1ZXN0IHNwZWNpYWxseSB3aGVuIHN1c3BlbmQg
aXMgZG9uZS4NCj4gDQo+IERpZCBJIG1pc3MgeW91ciByZXNwb25zZSBmb3IgbXkgc3VnZ2VzdGlv
biBmZXcgZGF5cyBhZ28gaW4gWzFdIGZvciBub3QgbWl4aW5nIHJlc2V0IHdpdGggc3VzcGVuZD8N
Cj4gDQo+IFdoZW4gbmV3IGZlYXR1cmUgYml0IG9mIHN1c3BlbmQgaXMgb2ZmZXJlZCwgZ3Vlc3Qg
d2lsbCBfbm90XyBkbyByZXNldCwgaGVuY2Ugbm8gbmVlZCB0byBtaXggcmVzZXQgd2l0aCBzdXNw
ZW5kLg0KSSBkaWRuJ3QgZXhwcmVzcyBjbGVhcmx5IGJlZm9yZS4gSSB0aGluayBJIG5lZWQgdG8g
Y2xhcmlmeSB0d28gdGhpbmdzLg0KMS4gSSB0aGluayB5b3UgYWxzbyBtaXN1bmRlcnN0b29kIHRo
ZSBpbnRlbnRpb24gb2YgbXkgcGF0Y2guIFdoZW4gSSBzZXQgZnJlZXplX1MzLCBpdCBpcyBub3Qg
dG8gdHJpZ2dlciBhIHN1c3BlbmQgdG8gZGV2aWNlLCBpdCBqdXN0IHNldCBhIGZyZWV6ZSBzdGF0
dXMsIGFuZCB0aGVuIGRldmljZSBjYW4gZG8gc29tZXRoaW5nIGFjY29yZGluZyB0byB0aGUgZnJl
ZXplIHN0YXR1cyhub3QgdG8gZnJlZXplIG9yIHJlc2V0IGRldmljZSkuDQoyLiBJIGRpZG4ndCBt
aXggcmVzZXQgd2l0aCBzdXNwZW5kLiBBY3R1YWxseSwgaW4gY3VycmVudCBrZXJuZWwgY29kZSwg
ZHVyaW5nIFMzLCBpdCBkb2VzIHJlc2V0IGFmdGVyIHN1c3BlbmQsIGFuZCBhbHNvIGRvZXMgcmVz
ZXQgYWdhaW4gYmVmb3JlIHJlc3VtZS4NCg0KPiANCj4gWzFdIGh0dHBzOi8vbGlzdHMub2FzaXMt
b3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMzA5L21zZzAwMjYwLmh0bWwNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

