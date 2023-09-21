Return-Path: <virtio-dev-return-13918-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517F9E706FA
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:26:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9384C7957C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:26:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F34A9866B2
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:26:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6526298668B; Thu, 21 Sep 2023 09:26:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50A2798667E;
	Thu, 21 Sep 2023 09:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfH8Djo3uB8f6XSFGwTWVIX7sP9B/7Y96K9xOFife8SSTA6FqaLiUtob6UECsQ8UYdotp02yshCEl0D6YOWLiumhzDxV7jP1o8RE9dXTb4SOu0UulD6TotHtk4sqqM9/qrn3ol8QWoI2mlhoZbpoSI7Z3r7xAhfFzDjmZaN+8Z+6StIhGJcGLvjE4RHRROMzCxIOaLY/NmxjnOsaCr8bA5VqA+CcIzwBkAEOPoONctDDRli/e5auZg0Fl9tXvWpxDAcfO7SzbQCNvUZ5zVwsQMD4pj05ayj5W3Lrj5wuMP8R6YwgKAzc4Zpgs6C0jxnYXqY7Uh5r7i2bm6DSaXhQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2rVee+W4iU53STsCTbNcJ9r/1lDDjhIgjpRsxW8vg4=;
 b=CovpLTTZjcSRXbj7xdoYwtJVLiXM5/N5SnyRqF+sUiTb2ijYAsif/tEm5i6z4+pPq6r5mQeWc/xQmyD4ZmrQQ8WEoYZ2k57MoW9dGQJbJUnFvRbuwP6YFZWUwvbf77Rg6rooz/hK7jUZKAGZdQEGZS6jYUXioKiMoDzqUwC1JVyedwROcRL63IXHnhNqVow+uH0+MVUmKghRnD5qPwvQB6TUg8aPVTcs0UHXe5UUCKyVj7fMWMNTwrqeUPPinPnom0uGNz2B1yAQFZIXN0qpuXkixsgKlgVD0F6TeoB/CfFsX5lXttk4UcV+pwa605OwpEPIiIxIw0BVPSeOAb62Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jason Wang
	<jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAAVfAgIAAAElw
Date: Thu, 21 Sep 2023 09:26:27 +0000
Message-ID:
 <PH0PR12MB548188F479E7D7FF56845F39DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e8d00e8c-fe32-83fc-fd13-edf3458b8c33@intel.com>
In-Reply-To: <e8d00e8c-fe32-83fc-fd13-edf3458b8c33@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4298:EE_
x-ms-office365-filtering-correlation-id: 46c62015-efd0-4463-fb54-08dbba84d4d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z7sehAp488+AheHNpZQRl2sM9dOp++S61r9/TasPFCACZXLU673E3wzHnt2R+pBekIrcOmydYXRdamTQHkeObQuhJ1gXFHUoZklnSvWeZVH9A2tXtZ7e9OwqSjGTdw/GsnqBJffVa0YmwmlewWdvdn9PnjAbyx0xb1bbXzo77W48rqG/E+cPCFB7sZY9r2KTZ6Kxr9rv50h91Jsl20lvSk5rq3DJ7y8L/lpIWcsqYhvNaLjqHVml+1xanJU/flZEw3jg0G2ENuw6NfcMPbboI9Mg4qnS4j2KBHcAz66lzL+uhST6Q8rlRzMGxpPVevjyeMAgFQAgBE6dggtMbB553ErkooHT4+x1NrsFWrtCmoRHJ9NCXeH4Bh+rkiftj04I/kAGFOYYXRkMdqAJqFXDw3aO0fpohbBVAQOtuLoEJq1XlNWWt3KaNAgJoI6q9ZhAQCZLKGu3+DB2nEsx6oRieYrvA605Hfuhkp5RNuGYnim2FICcRoYaLoOYeOyg0tcVBlgAnwVEKr/e2B6UF7/FQ++cRSV0IahYv8vWLsoFMromREH3SXZyjcD3CjhXYtkOMOKmluJVPL/2zPDly/SATbZPMk8PwWzTXbLC1+sQOo5LmhAkwaVFRGsV2Dcfdl1fpsRrh4H9tVXNQd203xLvJ30yI3027MliatWlCZLLQmk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(71200400001)(478600001)(55236004)(7696005)(6506007)(966005)(83380400001)(8676002)(66946007)(64756008)(2906002)(26005)(41300700001)(54906003)(110136005)(66446008)(76116006)(66476007)(316002)(66556008)(52536014)(5660300002)(8936002)(4326008)(9686003)(33656002)(86362001)(122000001)(38070700005)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmtWWnVFUVhTQm1TeWpCTVhMbXBTL2RES2dMZXM3UWl0ckZnMW9VdStiY2Ji?=
 =?utf-8?B?TGQvOGphcUsvdC9OSy9zTjlPanpZNVRNOE14UnU5R3dyQ2FBYUF3MmJLUGow?=
 =?utf-8?B?V01ncG13dmxQOVl6dU8zTDdBeUY1a01FcWlnRFlDOStDNGlqVXJ5dGJPNDNt?=
 =?utf-8?B?T3pnZ0hLRXl0cUhJZW0vL0pFQzdOQWlzTENuOTlvMWtVSEs0ZElxSjJVSXpx?=
 =?utf-8?B?TVpkelF4Rm5oOTdKWjdubURzd2w0TkVRM0NORHBsQ0YwdEJXZ0N2UHhmaEJr?=
 =?utf-8?B?N2VYeUpBUElNbiszNHVnQWM5V1Bzd2x6VDNpSjF6MExoMDRHVWU1OUtQOUpp?=
 =?utf-8?B?Q1ZiUExCamdnbFovamI0cllrNDJiYmFTdEJKbEJ3dmkveWpqQnc4ZG50ZkVh?=
 =?utf-8?B?Rm5uWGh1UmlEWVlkK1UvRWJUYlNaeG0xank3MzRNMEJlZDI0WHdGcjRGa1dY?=
 =?utf-8?B?TTY4Y2ljV1Z3STNvTFQvL24xUlNNUm82amZxS1d1cHZVTWd3TVQ4aUE1ZHhl?=
 =?utf-8?B?TXJJSDVLVVZDaXFMMklqNDRpbnUzMEZOaGpyN0tOYW1KODVMVmViNVk0ZDhG?=
 =?utf-8?B?YXVFWFFueGplaU44bDRRQ3FQRUdadHFkMjBRVmwzbGZGL2JZZWwxcU15cXQv?=
 =?utf-8?B?VE1lakFVZWllUVB6RDlqd3pwaS9KdlkrYVZsUWdjU0hZNXZOZlFqaGRxUldH?=
 =?utf-8?B?T0Vtc2JrYVlOMTUvU0xFNVJXSWNqbkg1dUxPZEZUVkY5UkRFMnliSHIzSWg5?=
 =?utf-8?B?c3phamc3K25CbFlxWThGVHZNdGdnM2pxZGFjdUR0WlN3K0doT01UMWgxR0pL?=
 =?utf-8?B?dXgzZllTZVpQRXV1eWJqRVRiL3l4WUc4djFmNHZvbElwWW9yNUZQTFFDek1k?=
 =?utf-8?B?eUhrMDVjd1JtdTZSWXRCam9aNGE4QU4rVHBVK2pSbGgzSmxOTXNxUmhETllR?=
 =?utf-8?B?TTk5ZTdxNFhCR295UktYTnJhYUQ5MmdKM1plMVJ0QkJjSFRiN0F0ZCticzND?=
 =?utf-8?B?OXBNcWZsdytSZkE4WG1CdVBvUXFzVVFwUkRORTVJdStCdDJBaE92NVZJak14?=
 =?utf-8?B?cHFDRzZjTWpLS0p1N3c0eUNBUVg5eFJqY2ovYXJEMFhKdjFVc1VwNnA5OExw?=
 =?utf-8?B?bjRNdThvZ00wRUhsOFZvRitEREwzSEJJLy9oQk1TMGNqbnYwankyZ21yMnB3?=
 =?utf-8?B?M3RDU1V4aVJJRGp6SDltRENHeUNrN1RCbzZGVG80T3VWaE00T1pnN3dmejJS?=
 =?utf-8?B?YXpCYlNaMk9xTlU4cjU4RnB5OEEvL2Q0MkNYc1B5OGtsWS9MRTFkYzBYTzNx?=
 =?utf-8?B?OGxtMjREVGRoRUJRSFowM2ZlZmIrZ2ZoUEVONk93U3YzUjRhd3ZoRzZuUEhs?=
 =?utf-8?B?U1RHSG1qMkczMkVFYU03Ty80VURYU2pCR29ranlzL05iaTN5REMyQnVqaXhQ?=
 =?utf-8?B?bTRhVjZ1bmRZam50MXdzeFdLSjRJS0x0Mzhlay9yYWVBZlVva29HNXhEYUV3?=
 =?utf-8?B?L0NMRk9rdVIrRm40K1FLOUIvdVFUajg5SzRQeERMVW5RaE1oSWx3R3dpSWM2?=
 =?utf-8?B?TlQ1dEZ6NElVRXFVR2U2WnRTQ1JPWlNVQ3k0ZE85K2srTy95TWtwNFROcVZP?=
 =?utf-8?B?NWptRVc0dG8zYmovaGEvaUhMYzkramwzbWdlMEpncUVwWGlVVG16ak8zTlYr?=
 =?utf-8?B?VDIyK3ZIUmFlSHVuYnNXdGwvc0RSQ3VBOVFZOXI3bmxqV1ZqeVAvMlk5cStC?=
 =?utf-8?B?dFkrODFjWVVxakJqZnkrcCtuRGdOUS9NOXNhTGk0T2FDTXNZSDM1ZlJqRDlC?=
 =?utf-8?B?bmJkSFhUaUloaHlvZ2t6SG1BMEdDRzk2bUlUeHhjZ05HRUxUdnJINGpYZUxL?=
 =?utf-8?B?bEg1SVFIQzJMNEZwSlptL1lwOWJBTGpGU3JMRGduN2w2TWhvenRoN2ZQUFN6?=
 =?utf-8?B?akhvUFVrQXI1WjVHVk1yc0ErN3RuWXY1djM2TnJjOUlqSlMwdm1IdXdSWjZs?=
 =?utf-8?B?L2VreWE0dzNhaWNKM0xDMEI5M3J3VlV2MDlxNjI1aTRhOGY3eGFRZUthUzJZ?=
 =?utf-8?B?aWJuVTZDVHhWb1ZQamN3eFNQTTY4aUhWM1NTVEtsRjVMMW5JN0VKcGJMQzBB?=
 =?utf-8?Q?4S5M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c62015-efd0-4463-fb54-08dbba84d4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:26:27.1961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8CwOtwKGFk+OsKn2fSRTaExGIWoJULQ+SNm6GaC8ruqxYc9xPAYhRjIvuFCEdNu3ZTEy19X18UfyINMm5ID7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyAyOjQ5IFBNDQoNCj4gVERJU1AgZGV2aWNl
cyBjYW4gbm90IGJlIG1pZ3JhdGVkIGZvciBub3csIGFuZCB0aGUgVERJU1Agc3BlYyBtYWtlIGNs
ZWFyDQo+IGV4YW1wbGVzIG9mIGF0dGFja2luZyBtb2RlbHMsIHlvdXIgYWRtaW4gdnEgTE0gb24g
dGhlIFBGIGV4YWN0bHkgbWF0Y2ggdGhlDQo+IG1vZGVsLg0KDQpJIGdhdmUgaGludCB5ZXN0ZXJk
YXkgdG8geW91IHRvIGNvbnN1bHQgUmF2aSBhdCBJbnRlbCB3aG8gc2hvd2VkIFRESVNQIG1pZ3Jh
dGlvbiB1c2luZyBhIGRlZGljYXRlZCBUVk0gdXNpbmcgc2ltaWxhciBtZWNoYW5pc20gYXMgYWRt
aW4gY29tbWFuZC4NCkJ1dCB5b3Ugc2FkbHkgaWdub3JlZC4uLg0KDQpTbyBsZXQgbWUgbWFrZSBh
bm90aGVyIGF0dGVtcHQgdG8gZXhwbGFpbiwNCg0KV2hlbiBpbiBmdXR1cmUgVERJU1AgZGV2aWNl
IG1pZ3JhdGlvbiB0byBiZSBzdXBwb3J0ZWQsIHRoZSBhZG1pbiBjb21tYW5kIHdpbGwgYmUgZG9u
ZSB0aHJvdWdoIGEgZGVkaWNhdGVkIFBGIG9yIGEgVkYgdGhhdCByZXNpZGVzIGluIGFub3RoZXIg
dHJ1c3QgZG9tYWluLCBmb3IgZXhhbXBsZSBhbm90aGVyIFRWTS4NClN1Y2ggYWRtaW4gdmlydGlv
IGRldmljZSB3aWxsIG5vdCBiZSBsb2NhdGVkIGluIHRoZSBoeXBlcnZpc29yLg0KVGhlcmVieSwg
aXQgd2lsbCBiZSBzZWN1cmUuDQpUaGUgYWRtaW4gY29tbWFuZHMgcGF2ZSB0aGUgcm9hZCB0byBt
YWtlIHRoaXMgaGFwcGVuLiBPbmx5IHRoaW5nIGNoYW5nZXMgaXMgZGVsZWdhdGlvbiBvZiBhZG1p
biBjb21tYW5kcyB0byBhbm90aGVyIGFkbWluIGRldmljZSBpbnN0ZWFkIG9mIGEgUEYuDQoNClRo
ZXJlIGFyZSBvdGhlciBzb2x1dGlvbnMgdG9vIHRoYXQgd2lsbCBhcmlzZS4NCkkgaGF2ZSBzZWVu
IGFub3RoZXIgb25lIHRvbywgbWF5IGJlIERQVS4NCg0KSW4gYWxsIHRoZSAyIGFwcHJvYWNoZXMs
IFRESVNQIGlzIG1pZ3JhdGFibGUgYW5kIHNwZWMgd2lsbCBldm9sdmUgYXMgbXVsdGlwbGUgdmVu
ZG9ycyBpbmNsdWRpbmcgSW50ZWwsIEFNRCBhbmQgb3RoZXJzIHNob3dlZCB0aGUgcGF0aCB0b3dh
cmRzIGl0IHdpdGhvdXQgbWVkaWF0aW9uLg0KVmlydGlvIHdpbGwgYmUgYWJsZSB0byBsZXZlcmFn
ZSB0aGF0IGFzIHdlbGwgdXNpbmcgYWRtaW4gY29tbWFuZHMuDQoNCkkgd2FudCB0byBlbXBoYXNp
emUgYWdhaW4sIGRvIG5vdCBrZWVwIHJlcGVhdGluZyBBUSBpbiB5b3VyIGNvbW1lbnRzLg0KSXQg
aXMgYWRtaW4gY29tbWFuZHMgaW4gcHJvcG9zYWwgWzFdLg0KDQpBcyBNaWNoYWVsIGFsc28gcmVx
dWVzdGVkLCBJIGtpbmRseSByZXF1ZXN0IHRvIGNvLW9wZXJhdGUgb24gZG9pbmcgam9pbiB0ZWNo
bmljYWwgd29yaywgc2hhcmVkIGlkZWFzLCBrbm93bGVkZ2UgYW5kIGltcHJvdmUgdGhlIHNwZWMu
DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0aW8tY29tbWVudC8yMDIzMDkwOTE0
MjkxMS41MjQ0MDctNy1wYXJhdkBudmlkaWEuY29tL1QvI21mMTViNjg2MTdmNzcyNzcwYzZiZjc5
ZjcwZThkZGM2ZmVhODM0Y2ZhDQoNCg==

