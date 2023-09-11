Return-Path: <virtio-dev-return-13664-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B751EE801F
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:59:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B628F42C24
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:59:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0B4B98648C
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:59:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A4063981BDD; Mon, 11 Sep 2023 06:59:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9554B98635C;
	Mon, 11 Sep 2023 06:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1iKXDwRt5GdFZRRfuAmXyDz5wrM/N/oFWSEvaD59oM8qhBXZo1iDltX4fiPoC6KGPokNleQ1AYL9iHlEM2UsfChbimIuNzfIhZHSQM/tMnpad4Rjq3YeE7FryPoR7fOreZdp0Wczx3dmUexLDMfHnEaFXWNGLv8hljkteJjtFZ3AD8217WWFc3CJnPXGzChpIQlQOhT0cXXPoaUpMEDfsyxccuT7NjkQnB3YXclQzrXno1tuA1IbUXZ6OXii8GmTAIxsfmVTccUuvY23ZrwkUQjdKxXukABPDQvokhxe8QC/nAgKmgR8ywMWMpUxPwdT6ugUQ6/bxMMedmw2T//Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcY66+wOyuHUMIJZkhixRgPUhzNcJfPw6Zs2V7zqcrE=;
 b=VNkHpwJScThnDq8gl4OUPoHPTzAEDqTJZevb+qG9hCSawwxtlrhM8vZLIhI1ZbLjJAT31XTUur6hv1HtS6DncpTzpgn2ZFG9EsKDeRQwDfO2y/lVJUaNCmsikd0hGVzF7LVKTEMc1mKN+RyZtRyx0ZGd5fnSAqxHkcJkB8s199HZYZoMXlNbgu933GMrlmdQTHpPmbYzr3EP7TWygS4PXQvwN9Wc/6NbRjbv2CD364bUhtuE//0Ef5ieGSF/gS3S8uKu+39srJmxQKvMWYs1okNoggmvWmfFyGTDFboDEduOq8L5K90p2u002V8RdiNusAHS13PeOoh9kw3ODfJcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index: AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAB20A
Date: Mon, 11 Sep 2023 06:59:29 +0000
Message-ID:
 <PH0PR12MB548180CDBE16656D3D2C8FC2DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
In-Reply-To:
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6091:EE_
x-ms-office365-filtering-correlation-id: 6b04a82f-d4ed-4cf8-0ed1-08dbb294a512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NdPL+AAoWm+OLKVY+jYC0Ne6ib5dy+IZJ+TYsgdwZMjsLmjXpgGA/dPe6hNsI0OyT64obsQOpFOmDAxAUCTGV5pHxaHjS5Ff4hXfFQdytfSoSLeAL3TeNQW46WIoCDCtBBLCvhWjV7QGlsXnXmML0K8NYefNDKUCBLk1QItizbwdLBZr/dFCn+QFoJSHELsBSRe7eoT0ADjMMAdhToaMGAlvrOMEyEQECBZrS47GKRH8zU1dm4dacBoGLH+uein77igf5wpp7xfT6UmZHoq6n2qAWcsEdUVoL9zaEDiB4Mnj61/bOXa2KkqaoIwKAlDEc9hwQlf5QCTPFnDdmU9X/wQjb8uS96D8VErd4GHoF1x8uI8WP8siuynEms7PdCgmT1apy+D6B+K4loKIl+Cu53R8nJn6UQgc7fv9/ZhRAVW/5kz2dFL998fa6dbr5PRV/wjUnAEUytwaJ6ht7pdW6bzIS8H63hljt/Z6KtCS8lcUFLj3XlsLgJ5N7nWTYb2AYSNqOY8rXVl+9E58c+qT2Co2yOAw0Fgt/LKNAVNNkWEyZNGzrTg6j43IaWMr/iUCZe7630mfzTC+DBSHziuMT71oAHanxjHSOIcSgLyODdlxBMqNclSwXQrI6sRATC5L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199024)(1800799009)(186009)(122000001)(71200400001)(7696005)(6506007)(33656002)(86362001)(38100700002)(38070700005)(55016003)(4744005)(9686003)(83380400001)(478600001)(41300700001)(52536014)(2906002)(4326008)(316002)(76116006)(8936002)(8676002)(5660300002)(6916009)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDJ2OElaM0lxRisvUkR3UXNublpOUTBKWHB4T1l2a0F3Qm5yeXB3eFIzNGJx?=
 =?utf-8?B?cHhLTXRXNDI1c09FN3dnTDgxcmc4b3ZwZVl2bHp5Ym90Ukp5L01QSFJ1Mjdp?=
 =?utf-8?B?VTQ5Qm5vNWlFbFpyYWhpWGJWcldOTDFRaXBsZFVQN3VLYXMwaWw2MVFIaXpC?=
 =?utf-8?B?Skp6U0VwVjhvZWZDcmgya1ZqeU9LamVRcHkyZE5NUkdpWGwzbGhuODI1ZFIx?=
 =?utf-8?B?aEtNQ1N3MFBrOW92V1A2ZDdxM1NIVU5rb0xUVlRYaHp1NllmeGlaYjVscEw1?=
 =?utf-8?B?R0puS2ZjYkRwQ002MFJmS204d2NTWGdyRDhTczdjcXV4cVBuWEJNRmI2M3I2?=
 =?utf-8?B?aHNvSUp2NVB4L2FkendiMlQvRC9udnN4UUd5T2xIc3VCZGMwbTdva0dyTVBn?=
 =?utf-8?B?YVFMeUx6RVZUQTdYT1Q0clVIWlB6L2R6NFJhdDB5bWNRZkhYUFliNlRnOURC?=
 =?utf-8?B?Y2NrM0NVZ3VoeXM2dWxrcFZPYzRkN3FpcEFRZjM0amlqUzg2NllFNVQxL05Q?=
 =?utf-8?B?QXp6M1lzdU9GU0Iwc3RtVDVSSDhueDFVazcyK05RM1hLMFhzdjNKeWZCSTdH?=
 =?utf-8?B?MmtWZjB6TnpnSy9laDZkejdkd3JyK216MGw4dGdFMktVSnJNc2VYcGJqQWhT?=
 =?utf-8?B?OUt1SjJSYjB6djdXaDVpNmI4K2pjc1k2eDFVdzZjN0ZHSXMvZDBQYW1NY1Zp?=
 =?utf-8?B?WjcyTExtUzg5UjNSYnNjY0RFOHFxanZWTTgyMHRhUmJYNWxnYytsc1U0QlR2?=
 =?utf-8?B?MjdkZFlLU0ZOWkFhWkxWY3BDK1RNMG5mZmExU1JaMlluQ1ZUM081NktjaG5n?=
 =?utf-8?B?S0tVOThIcVkvMTVWeGRVd2M2bFlKdzkvRitIdnhCdFlHOS8yS2tIOXdZb09n?=
 =?utf-8?B?SHhyd0orMDRhQWdZRXYzRzltL0xWU09MMFRIVm5jNk1kbEx1Z3pNbGp0OE81?=
 =?utf-8?B?UzRnMUJ6TkZ1ZWRJWGdKR21VYmo5blR1RW5lUGVka0xZRjJMV0kvUFVqREho?=
 =?utf-8?B?QXU2V2RCTDJCNW5wbHd6WlZvOHZRQUdLRHVOY0t6cnBiMFY4SlhIbDBoUXhh?=
 =?utf-8?B?VHZ2SmtMM09wQVhEVmxKMFNqWEp2N3N6SCt2bFdMbVY2WmpUOVAxb3NoSkp5?=
 =?utf-8?B?dmkwZitiT1h5YWZ6MHRtYXRSNlV1UjR4RVptaVZZbHEvRHhlYXA1bkRsWGFF?=
 =?utf-8?B?YU9QQlc0YUx3M2VIa1p6UjgzREJ2MDcySnJwOVJXWGZuQ0kwRnlSVGRHelpt?=
 =?utf-8?B?Qm1SeW5PRHZMeWFIV3NrVFRlWU40b1RDWFVGQnd3ZWgzbWRybG9UdldWSm11?=
 =?utf-8?B?OXE4Z2cxeWpRMVBtQThMQWdCQzZSOWJ0c2VHS3N5YjMwRDFvcSttR0EwaDZS?=
 =?utf-8?B?MEwyMHdocGc5TnVUc2JLNEJFT1IyU0pVVThnRmNaK0F5VjJQZ1FyV2NKSHFZ?=
 =?utf-8?B?SWhkTklaZHcyRTZEUWZJVU1mLzkwV2x6bXBMblFSekxNY0pLUnJxNzhxRHZM?=
 =?utf-8?B?WUJ0QnB3TWNlNUFCNDZJUjRHM1FCZlg4M0tOeE9sdjlacVY3bTZhT3JlSTFG?=
 =?utf-8?B?a29LV3p4d1NaZndaVmFPRVZMY1JENU4rRi9rWUdsODZ5Zm0yWkFvdUp5aVVZ?=
 =?utf-8?B?S2hrV2pLL1RnbEw0dmVqS24vRGJqaUFyeTN2STNOb2FIa1RVQmlyY3UyQ2dz?=
 =?utf-8?B?d0lHYWhwemxMaXlYK2Fxc0dyWXF1emZDbVJpcFRSeW9QN0lEOU45SHRsUkhI?=
 =?utf-8?B?ZmtlT1VmTUk3MkVVcFJINGZRZDlxTGVvUDJpTE85Nk1JU0g0ZEJLTXFIS3dS?=
 =?utf-8?B?ckFUa1ZIckdrWENTcWtLT1N0R09TMlhTN2c3UmtKT0J5S2xUaFJ6cmpUZ1dp?=
 =?utf-8?B?TmtJdnI0RUtMQW5kUjlhZFk0bWhqL0tKSUFPY3BZZWhPYU5zU2plZDNtcXpK?=
 =?utf-8?B?RkRVYWdTUzdrRUo5UEFOTjhmL3JpZkNWTGpwdURYek1taDlPSnBXK1k1aEtx?=
 =?utf-8?B?NVM5UjNsVmJqeERDN29BMTQwTS9GZ2M4NWNzOW9NNXR3UW01Wk9qZzVUKzhL?=
 =?utf-8?B?S1pGR3ZiT1JVRUdheHBDcy84U0hTdGNoTFBWZ2VLMitCMnNCWklhZDYremh2?=
 =?utf-8?B?bVFWNmNLT2Y3NUd4cERuaWNNT2c5MGNDZjNHZnFXbmhjU0s2d3AxelZFUkcw?=
 =?utf-8?Q?PKWEh/5M2vDHEz/TYPavBtpOEa9Rydy4KQTSBHWm1ZZF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b04a82f-d4ed-4cf8-0ed1-08dbb294a512
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 06:59:29.7364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irZlo+hk3BNPICwm4Q4xKWrL/5EaBibYZ30OM/7rJQPs1O4oTkUk6tq3E1bfNUfMZIeoZ/pwO/Rp8igZxI/xFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjMgMTI6MDEgUE0NCg0KDQo+IEN1c3RvbWVycyBkb24ndCB3
YW50IHRvIGhhdmUgYWRtaW4gc3R1ZmYsIFNSLUlPViBvciBQQVNJRCBpbiB0aGUgZ3Vlc3QgaW4g
b3JkZXINCj4gdG8gbWlncmF0ZSBhIHNpbmdsZSB2aXJ0aW8gZGV2aWNlIGluIHRoZSBuZXN0Lg0K
SXQgaXMgbm90IHRoZSBjdXN0b21lciB3YW50L2RvZXMgbm90IHdhbnQuDQpUaGUgcGNpIHRyYW5z
cG9ydCBzaW1wbHkgZG8gbm90IGFsbG93IG9uZSB0byBiaWZ1cmNhdGUgdGhlIFBDSSBkZXZpY2Ug
dG8gZG8gdGhpbmdzIGxpa2UgcmVzZXR0aW5nIHRoZSBkZXZpY2UgYW5kIHN0aWxsIGxldHRpbmcg
cGFydGlhbCB0aGluZ3MgcnVuIGxpa2Ugc29tZSBhZG1pbiBjb21tYW5kcyBvciByZWdpc3RlcnMu
DQpTbyBvbmUgbmVlZHMgdG8gZG8gdHJpY2tzIG9mIG1lZGlhdGlvbiBhbmQgYnVpbGQgdGhpbmdz
IG9uIHN1Y2ggZGVwZGVuY3kgZm9yIG5lc3RlZCB1c2UgY2FzZS4NCg0KQW55d2F5IG1lZGlhdGlv
biBhcHByb2FjaCBvZiBBUSBldGMgZG9lcyBub3QgYWRkcmVzcyB0aGUgYmFzaWMgcGFzc3Rocm91
Z2ggcmVxdWlyZW1lbnRzLg0KU28gYm90aCBhcmUgc3RpbGwgb3J0aG9nb25hbCBwcm9wb3NhbHMg
YWRkcmVzc2luZyBkaWZmZXJlbnQgdXNlIGNhc2VzLg0KDQo=

