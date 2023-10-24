Return-Path: <virtio-dev-return-14018-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA35EC00A8F
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 12:14:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 40D422236A
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 12:14:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A90C9869B1
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 12:14:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2D0629869A2; Tue, 24 Oct 2023 12:14:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A8D99869A3;
	Tue, 24 Oct 2023 12:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxWd4nJls1vCHq2blKEqEVNghexsfiTs8feox5C4GSqKfoEy5TiaeTgviEyRt8BgOMRU3xnMIfI41yQCa1yt9PAgaenfVpTKQIdUR7cbzvWabbzb4P9lKASReqxcgGFJSB0nFuQTzFqHCssCOvTCroL1VCU24hZVmCGTeplxGDZ2oXWoxD7TYW8A4fMPzPeFIQMc9AJ60249AGkn3+iu4QTNpvNKvOg25n8Ir5PpNMq71e0KuTLTkGdTwQ1xvY8Edbj6aXD5TyUDQeCoI75/q2f39aZs54TAW3sO1WRwCR8JJLddpftf3U/jcGXdql1QRFRo8Xldzn66/cYr9Zj2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOVFSl8kyWS39C1pUK0LNaIlvNK/RSl9HSEgjU5uKUc=;
 b=ItauEsXFjSeS5yOfa61APu0RLlFoQf9Pzqk0bIq18hC+HAxRHGChqRqMw613c/7yDsQrzKok0/v7skoZomeLboftlDH966hy8u1vC9CLzShQM9bKwi+Nl/8jjNCb1spwokpmAsOvMLDSLcBM6NCby6WyzX0S7v1SqHyP4CC34Ooog6pBjRIC21RuPrz2SRXEEOqMIo2UbLxttJFYdyp2YwqIO3KwrEYhDqLlYdEVaXrcU3HLKSglX+QvjEcNUY9JZoC85ikZRf/3juRPyBxuwKH6RgpSLRcfsbdSIkcmnE1P4s2NKpCsfU4iYq9oFaXcPQat7J96ohAuZ3i8evIL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgA==
Date: Tue, 24 Oct 2023 12:13:53 +0000
Message-ID:
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6886.034)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BY5PR12MB4274:EE_
x-ms-office365-filtering-correlation-id: a9ca6c71-5a32-40ed-25c2-08dbd48ab040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7UFUVhO6V6W0z85eY+l6azYlUi0I9eVkvO1SnuWPrSP24p/MS8rEKxIYJqwvyCWC7iAbtQOZ1Jca2phUUu2EZEQ5iEFDS16RFCbg5xywPMMfQxJZ1641YwZeAOm/0USNhaoijQ5whzDZ1qJa//id11YeqYYx2GflTsIUzTuM7/WryGH9sOdWrbXswu+k3Jz/eCl0sXctGUK6Sjm7k4eWwOHr88yYAVcgoTbk9gff3jaTEtBVAYgfU7HNFzK+k1jj1ftV+dbnRhsfm8Zx4HhLPe5hHxUJ5sGskz/8aIWCkyrqGQWJQJQhPgjKLsoFtokIys8ZCoLEFPiOPYekaMwGGzxpioipEFXEQEf2ocyR+0b7iZQrCKQRwBrZSlyA7kEzmHp95IY3sOGHr3uTVxi3HQogicNEUtR8FtmbPuWNq+uA0Xti2PuJlJKCIQfvYxWwa75JmX8ASnb2PA5rY2ue+Fb06hGMJDuvgXgbw3CzB+5b8uRX27iUHfuePL0fK1FMvKPxJJm8Z25g2JIywvYaTPIO18JTCTC/VTNoXjlrI7CXnB8WkXqMMfQJxQIFEWSy9CklcMVxR6esndlgrPP+s/68qHsXTKSH8tX8u2TcMejYp2v+8BGXjDjfshoRUQsF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(55016003)(316002)(7696005)(53546011)(54906003)(26005)(9686003)(76116006)(66946007)(478600001)(6506007)(71200400001)(83380400001)(122000001)(38100700002)(64756008)(5660300002)(7416002)(66556008)(41300700001)(66446008)(66476007)(8936002)(8676002)(52536014)(4326008)(38070700009)(33656002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFNzcGJzVzdhMkZXcEM5WHlpUW9RZHdqS25ybmtnMXJNb2tWVmdURHVNaDdV?=
 =?utf-8?B?UkNWeno1SzJxdGU2T0lZUDI3bVR5Q2Q5QnNPMGdqYTUvOEdoaGl6ZVZldG5E?=
 =?utf-8?B?Vkx2cXlwcXZmcG1DQ2ZOc0p1cjVTRDJMZFNrQWdLcWVGM2JrTXNhZFVHbVBI?=
 =?utf-8?B?Q0FvOVFyV25NWVhXNHRKeXFmZ2llTExYWDhRVXJ4ZFMySXVmeURWV2hvREFq?=
 =?utf-8?B?Z3BQSXdQeVpRSEhBNDRaSXZld2NNTmpNYzVPZVNuZ1NleGdHYnF1cmNnMERO?=
 =?utf-8?B?LzRRdHd4NzJiSTZYWE1XaWZ0OFJMMDhCZ3h3WVduaGswMDBOditMcCttTHJa?=
 =?utf-8?B?eXpMTVAvT0orK1psTkZMaTZ0VkVHVTZqdGwzZzJ5VWcxNGtHb01PYjlCRjg5?=
 =?utf-8?B?N1g4U2Q0NTFPeU9neVJxakFqSG1VTlY3SGQ1cm9rUDk3NS9paFh2VnJKSUt0?=
 =?utf-8?B?SlZMalo0N3MwbHBrRE0yREtVaFBYZGFKOFBGa3EwdmNFQndxZDlrUjMxNEE5?=
 =?utf-8?B?Zk5MSXNQKzRPdHJ2bnJPNHhkdnplbXBoNEdxeFNTcXRVR0pLTXoraWFGeUpu?=
 =?utf-8?B?Vm9QbFNqSENYdkc0NkdOd3UxYW5NeFg3WnhBWG9pd2VwTm5KZjhEY1UvWDY3?=
 =?utf-8?B?MWtBQ1JiQzYrdlhueEZBaWN0NldzZ3h2dEdaQmluZ3pnOEUrM011VjF6VjBs?=
 =?utf-8?B?M1F0SXBKZVh5UWJpWEVRQjBaUjVWUUg3VmM1aWdNY1hPaDJGdnR4QTJkUzJv?=
 =?utf-8?B?R05BaEpNU2tmQjROb0tvR2dEVjNINUJ1bElvY2FHSTBJdWpCc2lnbGRPWXVM?=
 =?utf-8?B?cmk2SkFCU1pwMlFpYlhuTVBWaUIzRUk3WE80dlg0NjNDU0NCMktwNzdvQWtT?=
 =?utf-8?B?aXl5Yk9pQUROOXloemNiakhHKzFRVnc3K0M4aUh6UDRmRlg5WFJjZlY3VXZE?=
 =?utf-8?B?aS9YekdLTDhKYkwwbEhObTB4Und2MndKUHJKYk5GTkZCcnFNbzYxbUFHL0dC?=
 =?utf-8?B?T1JQZXczdkFBU25UMUo4dXZhc2UzUmdyazBZblRLaWJtRmd1bTlwejZkYUV1?=
 =?utf-8?B?NXdaNmVTaEp1NkRRcXpUYjhqODFGSHd6VzFXQlpHSFdvN3RkdnpFMjNGcnVm?=
 =?utf-8?B?S1EwLzQ5THNEUTJXOEt2M3pxdVJsZ0JqT0pBWTFXaG9oODhUM0VKb2pCZW9p?=
 =?utf-8?B?Wjc3SHUwc2FzcC9WUGVFVmIwQjc5ZEdzTzdPenZjb0NEMUZZVmZFdVJONGpY?=
 =?utf-8?B?ekp1cjJMY3BCVEMxQlJvWWhIemFCZ3NwenV0bHdXL1lpZ3ZRcnRBOWx0L0tO?=
 =?utf-8?B?TzdaK29ST0ZkNk1ISEVIY3VrV1RweERTYlNVTFlLVE1YVVEwcUZkdUJ3enBU?=
 =?utf-8?B?RUtZRVBMbDcvc3dFb0xhd0RYNGJvU2ZoOEprcW1ieFRobmdXSU51eG04czZM?=
 =?utf-8?B?VzRheVUyREZjbUdyRmd0MnRQNWw2dEIvd2NmcHVNOW5nbEdCeUp3L0dlMkd6?=
 =?utf-8?B?SWgrc1ZOMERqR1cwY2xOUkZPSGFpWWgrcHlPS2JDUklXc0p3K2doUDVZMi85?=
 =?utf-8?B?b0lWK1BMSXQwQmZaL2hVNXRJcEtOaG1ETEpwdTMyV0tLOUp4eEtsVzF5ckxB?=
 =?utf-8?B?STZ1OWszYTh5QnNYK09DNXU4ak84QVpHMDNVNnRoUUQyQUFCS2g0RU1Ccms0?=
 =?utf-8?B?NDZ4V096S2h6NnowdWVlL3RMOXBsTlVEbGxVMlZ4SVkrVnIxZGlkcUN4RzdW?=
 =?utf-8?B?c1lweFphZ09IaVNGUHlxbDZOMjdoaUZOaVl4ZTh6b2tTVTdCS0g4aUFOSzhN?=
 =?utf-8?B?ZUhJbWN1ejkrRmlhSWIyS3UzS0lVVUJsRGF4azRkTDhXb3hKWFRjVUdwa01P?=
 =?utf-8?B?dFFtcVZlQXQ5bks2VkdrUzZsVHlQQUFEYytVaXR2Ung4dWlOU0paTnRiS3lL?=
 =?utf-8?B?UlBwZktXUVNSc2NzS2hkOXZvUGdkMXltWnJtWFBZekFPU2VqMXRuamFOalZS?=
 =?utf-8?B?RlBPOFI0R1FIVHBMVDh5MUE4MVRYd2lpcC9VNmFhK0hqTnl4SzhHMElkaE14?=
 =?utf-8?B?VHo5YnN5SjJxcGRibTdLZnMrZ0NlVUF5T0VlamZSUWJIcGdIcGdScG1XS0tP?=
 =?utf-8?Q?/3Os=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A9BF68B91A8F64DB72EE63094565CCF@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ca6c71-5a32-40ed-25c2-08dbd48ab040
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 12:13:53.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imfyJVinW66WmD0JQL2lYP4uBNV42m4L07g8PZu5UaWX7TSufqUoE/1edH+JRlIeVAgjRpH8CKIsFoer5sT9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyMy8xMC8yNCAxODo1MSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiANCj4+IEZyb206IENo
ZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+IFNlbnQ6IFR1ZXNkYXksIE9jdG9i
ZXIgMjQsIDIwMjMgNDowNiBQTQ0KPj4NCj4+IE9uIDIwMjMvMTAvMjMgMjE6MzUsIFBhcmF2IFBh
bmRpdCB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFt
ZC5jb20+DQo+Pj4+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyMywgMjAyMyA0OjA5IFBNDQo+Pj4N
Cj4+Pj4+IEkgdGhpbmsgdGhpcyBjYW4gYmUgZG9uZSB3aXRob3V0IGludHJvZHVjaW5nIHRoZSBu
ZXcgcmVnaXN0ZXIuDQo+Pj4+PiBDYW4geW91IHBsZWFzZSBjaGVjayBpZiB0aGUgUE0gcmVnaXN0
ZXIgaXRzZWxmIGNhbiBzZXJ2ZSB0aGUgcHVycG9zZQ0KPj4+Pj4gaW5zdGVhZA0KPj4+PiBvZiBu
ZXcgdmlydGlvIGxldmVsIHJlZ2lzdGVyPw0KPj4+PiBEbyB5b3UgbWVhbiB0aGUgc3lzdGVtIFBN
IHJlZ2lzdGVyPw0KPj4+IE5vLCB0aGUgZGV2aWNlJ3MgUE0gcmVnaXN0ZXIgYXQgdHJhbnNwb3J0
IGxldmVsLg0KPj4gSSB0cmllZCB0byBmaW5kIHRoaXMgcmVnaXN0ZXIocGNpIGxldmVsIG9yIHZp
cnRpbyBwY2kgbGV2ZWwgb3IgdmlydGlvIGRyaXZlciBsZXZlbCksIGJ1dCBJDQo+PiBkaWRuJ3Qg
ZmluZCBpdCBpbiBMaW51eCBrZXJuZWwgb3IgUWVtdSBjb2Rlcy4NCj4+IE1heSBJIGtub3cgd2hp
Y2ggcmVnaXN0ZXIgeW91IGFyZSByZWZlcnJpbmcgdG8gc3BlY2lmaWNhbGx5PyBPciB3aGljaCBQ
TSBzdGF0ZQ0KPj4gYml0IHlvdSBtZW50aW9uZWQgYmVsb3c/DQo+Pg0KPiBQQ0kgc3BlYydzIFBD
SSBQb3dlciBNYW5hZ2VtZW50IENhcGFiaWxpdHkgU3RydWN0dXJlIGluIHNlY3Rpb24gNy41LjIu
DQpZZXMsIHdoYXQgeW91IHBvaW50IHRvIGlzIFBNIGNhcGFiaWxpdHkgZm9yIFBDSWUgZGV2aWNl
LiANCkJ1dCB0aGUgcHJvYmxlbSBpcyBzdGlsbCB0aGF0IGluIFFlbXUgY29kZSwgaXQgd2lsbCBj
aGVjayB0aGUgY29uZGl0aW9uKHBjaV9idXNfaXNfZXhwcmVzcyBvciBwY2lfaXNfZXhwcmVzcykg
b2YgYWxsIHZpcnRpby1wY2kgZGV2aWNlcyBpbiBmdW5jdGlvbiB2aXJ0aW9fcGNpX3JlYWxpemUo
KSwgaWYgdGhlIHZpcnRpbyBkZXZpY2VzIGFyZW4ndCBhIFBDSWUgZGV2aWNlLCBpdCB3aWxsIG5v
dCBhZGQgUE0gY2FwYWJpbGl0eSBmb3IgdGhlbS4NCkFuZCBhbm90aGVyIHByb2JsZW0gaXMgaG93
IGFib3V0IHRoZSBNTUlPIHRyYW5zcG9ydCBkZXZpY2VzPyBTaW5jZSBwcmVzZXJ2ZSByZXNvdXJj
ZXMgaXMgbmVlZCBmb3IgYWxsIHRyYW5zcG9ydCB0eXBlIGRldmljZXMuDQoNCj4+Pg0KPj4+PiBJ
IHRoaW5rIGl0IGlzIHVucmVhc29uYWJsZSB0byBsZXQgdmlydGlvLSBkZXZpY2UgbGlzdGVuIHRo
ZSBQTSBzdGF0ZQ0KPj4+PiBvZiBHdWVzdCBzeXN0ZW0uDQo+Pj4gR3Vlc3QgZHJpdmVyIHBlcmZv
cm1zIGFueSB3b3JrIG9uIHRoZSBndWVzdCBzeXN0ZW1zIFBNIGNhbGxiYWNrIGV2ZW50cyBpbg0K
Pj4gdGhlIHZpcnRpbyBkcml2ZXIuDQo+PiBJIGRpZG4ndCBmaW5kIGFueSBQTSBzdGF0ZSBjYWxs
YmFjayBpbiB0aGUgdmlydGlvIGRyaXZlci4NCj4+DQo+IFRoZXJlIGFyZSB2aXJ0aW9fc3VzcGVu
ZCBhbmQgdmlydGlvX3Jlc3VtZSBpbiBjYXNlIG9mIExpbnV4Lg0KSSB0aGluayB3aGF0IHlvdSBz
YWlkIHZpcnRpb19zdXNwZW5kL3Jlc3VtZSBpcyBmcmVlemUvcmVzdG9yZSBjYWxsYmFjayBmcm9t
ICJzdHJ1Y3QgdmlydGlvX2RyaXZlciIgb3Igc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2sgZnJvbSAi
c3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIHZpcnRpb19wY2lfcG1fb3BzIi4NCkFuZCB5
ZXMsIEkgYWdyZWUsIGlmIHZpcnRpbyBkZXZpY2VzIGhhdmUgUE0gY2FwYWJpbGl0eSwgbWF5YmUg
d2UgY2FuIHNldCBQTSBzdGF0ZSBpbiB0aG9zZSBjYWxsYmFjayBmdW5jdGlvbnMuDQoNCj4gDQo+
Pj4NCj4+Pj4gSXQncyBtb3JlIHN1aXRhYmxlIHRoYXQgZWFjaCBkZXZpY2UNCj4+Pj4gZ2V0cyBu
b3RpZmljYXRpb25zIGZyb20gZHJpdmVyLCBhbmQgdGhlbiBkbyBwcmVzZXJ2aW5nIHJlc291cmNl
cyBvcGVyYXRpb24uDQo+Pj4gSSBhZ3JlZSB0aGF0IGVhY2ggZGV2aWNlIGdldHMgdGhlIG5vdGlm
aWNhdGlvbiBmcm9tIGRyaXZlci4NCj4+PiBUaGUgcXVlc3Rpb24gaXMsIHNob3VsZCBpdCBiZSB2
aXJ0aW8gZHJpdmVyLCBvciBleGlzdGluZyBwY2kgZHJpdmVyIHdoaWNoDQo+PiB0cmFuc2l0aW9u
cyB0aGUgc3RhdGUgZnJvbSBkMC0+ZDMgYW5kIGQzLT5kMCBpcyBlbm91Z2guDQo+PiBJdCBzZWVt
cyB0aGVyZSBpc24ndCBleGlzdGluZyBwY2kgZHJpdmVyIHRvIHRyYW5zaXRpb25zIGQwIG9yIGQz
IHN0YXRlLiBDb3VsZCB5b3UNCj4+IHBsZWFzZSB0ZWxsIG1lIHdoaWNoIG9uZSBpdCBpcyBzcGVj
aWZpY2FsbHk/IEkgYW0gdmVyeSB3aWxsaW5nIHRvIGdpdmUgYSB0cnkuDQo+Pg0KPiBWaXJ0aW8t
cGNpIG1vZGVybiBkcml2ZXIgb2YgTGludXggc2hvdWxkIGJlIGFibGUgdG8uDQpZZXMsIEkga25v
dywgaXQgaXMgdGhlIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNX0JJVC4gQnV0IHN0aWxsIHRoZSB0
d28gcHJvYmxlbXMgSSBzYWlkIGFib3ZlLg0KDQo+IA0KPj4+IENhbiB5b3UgcGxlYXNlIGNoZWNr
IHRoYXQ/DQo+Pj4NCj4+Pj4+PiAtLS0gYS90cmFuc3BvcnQtcGNpLnRleA0KPj4+Pj4+ICsrKyBi
L3RyYW5zcG9ydC1wY2kudGV4DQo+Pj4+Pj4gQEAgLTMyNSw2ICszMjUsNyBAQCBcc3Vic3Vic2Vj
dGlvbntDb21tb24gY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUNCj4+Pj4+PiBsYXlvdXR9XGxhYmVs
e3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+Pj4+Pj4gICAgICAgICAgLyogQWJvdXQgdGhlIGFkbWlu
aXN0cmF0aW9uIHZpcnRxdWV1ZS4gKi8NCj4+Pj4+PiAgICAgICAgICBsZTE2IGFkbWluX3F1ZXVl
X2luZGV4OyAgICAgICAgIC8qIHJlYWQtb25seSBmb3IgZHJpdmVyICovDQo+Pj4+Pj4gICAgICAg
ICAgbGUxNiBhZG1pbl9xdWV1ZV9udW07ICAgICAgICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIg
Ki8NCj4+Pj4+PiArICAgICAgICBsZTE2IHByZXNlcnZlX3Jlc291cmNlczsgICAgICAgIC8qIHJl
YWQtd3JpdGUgKi8NCj4+Pj4+IFByZXNlcnZpbmcgdGhlc2UgcmVzb3VyY2VzIGluIHRoZSBkZXZp
Y2UgaW1wbGVtZW50YXRpb24gdGFrZXMgZmluaXRlDQo+Pj4+PiBhbW91bnQNCj4+Pj4gb2YgdGlt
ZS4NCj4+Pj4+IFBvc3NpYmx5IG1vcmUgdGhhbiA0MG5zZWMgKHRpbWUgb2YgUENJZSB3cml0ZSBU
TFApLg0KPj4+Pj4gSGVuY2UgdGhpcyByZWdpc3RlciBtdXN0IGJlIGEgcG9sbGluZyByZWdpc3Rl
ciB0byBpbmRpY2F0ZSB0aGF0DQo+Pj4+IHByZXNlcnZhdGlvbl9kb25lLg0KPj4+Pj4gVGhpcyB3
aWxsIHRlbGwgdGhlIGd1ZXN0IHdoZW4gdGhlIHByZXNlcnZhdGlvbiBpcyBkb25lLCBhbmQgd2hl
bg0KPj4+Pj4gcmVzdG9yYXRpb24gaXMNCj4+Pj4gZG9uZSwgc28gdGhhdCBpdCBjYW4gcmVzdW1l
IHVwcGVyIGxheWVycy4NCj4+Pj4+DQo+Pj4+PiBQbGVhc2UgcmVmZXIgdG8gcXVldWVfcmVzZXQg
ZGVmaW5pdGlvbiB0byBsZWFybiBtb3JlIGFib3V0IHN1Y2gNCj4+Pj4+IHJlZ2lzdGVyDQo+Pj4+
IGRlZmluaXRpb24uDQo+Pj4+IFRoYW5rcywgSSB3aWxsIHJlZmVyIHRvICJxdWV1ZV9yZXNldCIu
IFNvLCBJIG5lZWQgdGhyZWUgdmFsdWVzLA0KPj4+PiBkcml2ZXIgd3JpdGUgMSB0byBsZXQgZGV2
aWNlIGRvIHByZXNlcnZpbmcgcmVzb3VyY2VzLCBkcml2ZXIgd3JpdGUgMg0KPj4+PiB0byBsZXQg
ZGV2aWNlIGRvIHJlc3RvcmluZyByZXNvdXJjZXMsIGRldmljZSB3cml0ZSAwIHRvIHRlbGwgZHJp
dmVyDQo+Pj4+IHRoYXQgcHJlc2VydmluZyBvciByZXN0b3JpbmcgZG9uZSwgYW0gSSByaWdodD8N
Cj4+Pj4NCj4+PiBSaWdodC4NCj4+Pg0KPj4+IEFuZCBpZiB0aGUgZXhpc3RpbmcgcGNpZSBwbSBz
dGF0ZSBiaXRzIGNhbiBkbywgd2UgY2FuIGxldmVyYWdlIHRoYXQuDQo+Pj4gSWYgaXQgY2Fubm90
IGJlIHVzZWQsIGxldHMgYWRkIHRoYXQgcmVhc29uaW5nIGluIHRoZSBjb21taXQgbG9nIHRvIGRl
c2NyaWJlIHRoaXMNCj4+IHJlZ2lzdGVyLg0KPj4+DQo+Pj4+Pg0KPj4+Pj4gTGV0cyBwbGVhc2Ug
bWFrZSBzdXJlIHRoYXQgUENJZSBQTSBsZXZlbCByZWdpc3RlcnMgYXJlDQo+Pj4+PiBzdWZmaWNp
ZW50L25vdC1zdWZmaWNpZW50DQo+Pj4+IHRvIGRlY2lkZSB0aGUgYWRkaXRpb24gb2YgdGhpcyBy
ZWdpc3Rlci4NCj4+Pj4gQnV0IGlmIHRoZSBkZXZpY2UgaXMgbm90IGEgUENJZSBkZXZpY2UsIGl0
IGRvZXNuJ3QgaGF2ZSBQTQ0KPj4+PiBjYXBhYmlsaXR5LCB0aGVuIHRoaXMgd2lsbCBub3Qgd29y
ay4gQWN0dWFsbHkgaW4gbXkgbG9jYWwNCj4+Pj4gZW52aXJvbm1lbnQsIHBjaV9pc19leHByZXNz
KCkgcmV0dXJuIGZhbHNlIGluIFFlbXUsIHRoZXkgYXJlIG5vdCBQQ0llDQo+PiBkZXZpY2UuDQo+
Pj4gSXQgaXMgcmVhc29uYWJsZSB0byBhc2sgdG8gcGx1ZyBpbiBhcyBQQ0llIGRldmljZSBpbiAy
MDIzIHRvIGdldCBuZXcNCj4+PiBmdW5jdGlvbmFsaXR5IHRoYXQgdG9vIHlvdSBtZW50aW9uZWQg
YSBncHUgZGV2aWNlLiDwn5iKDQo+Pj4gV2hpY2ggZG9lcyBub3QgaGF2ZSB2ZXJ5IGxvbmcgaGlz
dG9yeSBvZiBhbnkgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4+IERvIHlvdSBzdWdnZXN0IG1l
IHRvIGFkZCBQTSBjYXBhYmlsaXR5IGZvciB2aXJ0aW8tZ3B1IG9yIGNoYW5nZSB2aXJ0aW8tZ3B1
IHRvIGENCj4+IFBDSWUgZGV2aWNlPw0KPj4NCj4gUENJIFBvd2VyIE1hbmFnZW1lbnQgQ2FwYWJp
bGl0eSBTdHJ1Y3R1cmUgZG9lcyBub3Qgc2VlbSB0byBiZSBsaW1pdGVkIHRvIFBDSWUuDQpJIGFt
IG5vdCBzdXJlLCBidXQgaW4gY3VycmVudCBRZW11IGNvZGUsIEkgY2FuIHNlZSB0aGUgY2hlY2sg
InBjaV9pc19leHByZXNzIiBmb3IgYWxsIHZpcnRpby1wY2kgZGV2aWNlcy4gSWYgd2Ugd2FudCB0
byBhZGQgUE0gY2FwYWJpbGl0eSBmb3IgdmlydGlvLXBjaSBkZXZpY2VzLCB3ZSBuZWVkIHRvIGNo
YW5nZSB0aGVtIHRvIFBDSWUgZGV2aWNlIEkgdGhpbmsuDQoNCj4gDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KSmlxaWFuIENoZW4uDQo=

