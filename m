Return-Path: <virtio-dev-return-14228-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8595C3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:33:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B0C742AF7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:33:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8DDB98648B
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:33:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D37998403A; Mon, 15 Jan 2024 07:33:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74B58986367;
	Mon, 15 Jan 2024 07:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLyRsrQmIiAmL4a/3gCkh3tTU9r22QZZefl5Bo8nGovRi9N0+JQblawouwOWdN0mZnjeN8aMzDnC1F479JGbtbpXVCvvxJXWAiVCnM72d6sAR3WQw56SczbdmNBVLoPo22M5P+rDng9D0AeCphkTbTrivfgSz+e3K5RfrU5+hhYpnoFJ+WskVkly/K2SLJRgM8avJpThMZVN8TKPB1BkM532xUBeID2YWL/A57LdGmGVjSdQ94naPkDvzeN4x1BsagWTzacbQ5rO87IOv5/H/lfZF11UGqNMzNrikAVW4rHWclB6vtsX/q6FhY+qvSRLt8aHSg8C60Xz4fVuK0bvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aYvraeFIj0oOmB8bQxrbxrC7Gm/vmK2S0VhIXIwZgg=;
 b=L44b6MhftB95KwYZ28q45WSQGtJkQedjqkQX3AqTGn09rHeqTMxgpX+izPWQQi10kjjRt3iHIU2bG6R1Kqnc+usSuwAfNA4yKkUAFa1Sr5ZRyS07TN71Z+XJOYCQdNGyoJxytus66VIB1d7x+MopQzaqPYkJy6lg+M3uuWv1j4NPLaDwPjyTQx+etEi56p8a9V/7QqDcXrtmTbXzdc5fv7ISrSdfJGkK9tpCTz/Nr/msLOsrpShSyW+NujRpxPA0xFaE0ZxfXjrITDVyHSK2i+Pb4yv918XnTMuBf+xmhrU3WIU+QKUwjsDZE02AfuvdNKZ/B5O+ZZ95//KWePusKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
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
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4A=
Date: Mon, 15 Jan 2024 07:33:06 +0000
Message-ID:
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA1PR12MB8495.namprd12.prod.outlook.com
 (15.20.7181.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH8PR12MB6674:EE_
x-ms-office365-filtering-correlation-id: 501feb1b-742c-4132-3ab7-08dc159c3750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0U4FeFqs9Vx33Yazcn+DMt2VQpRT3jPsGlvBjTKtmRa/wpji9XtmoubvDnWLhrM2BB1ioEve6hdEJcbObcCT3oYCehGFV5MEoaRqIqgY8/h0fbm8YPeD7iCJYktaLheQ4M2j98Q7KxRsUZunc+LMCigO5NRn/Dg/yDtuaYNwPn7QXQU+Km9Xrp/wWVUErcVY3z/kmD4L/eZxgs8GgkbZSP1pUW/bUUMxtGC1K8Nif+xNXxfyjRIt81QSANuvlUh0ts1r+LcbD2E+Q/N8RJidbC2YSI6KEmXPw3OaSrAPepByQnj2u5tTt82YT8bYcbBv8ca0gIEC6oRzj8fWI6806/wWgsMLNjdl7jn76m/9cM/5oWjoTxwBsaqzM2PM8d7/Mh917ldknJwcj7lLt0f6bebtJ3Ofd/TS6bKhZ+/omBWXwFebTtHDlV/14/2fQdlGc17CAV4N5iQ0NRr9ypQ1/W+i4eBAVxwU/Cv2P+mtzM4MNsZChVpDN69RFDQPSoFTWizM1/Cd1O2EUSw0Ll6c6g8uu8WtvMrbbvK/SeMqICB5wwJxIZvIOMSdsxuL/bVlxl6bl5kKM9gSMx5v6Fs2+BTYRU8wo5l9UmYf9qCRYJg7wVLbIOELjGjk8x2gX9Ks
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(9686003)(26005)(53546011)(71200400001)(122000001)(38100700002)(4326008)(7696005)(8676002)(5660300002)(52536014)(8936002)(41300700001)(7416002)(2906002)(6506007)(478600001)(66446008)(54906003)(66556008)(64756008)(66476007)(316002)(66946007)(76116006)(6916009)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkFMaW9WS2grcWxoYUNXazE2dEJ3NDJ2eUZWTzdRb0NEOXpFV2J2M3Uvbysr?=
 =?utf-8?B?NGJsS3ZrcXpBYUc5bWNMdUE2cFhua29jdGEzdE1ucmZBREVDTG9LQUQrYzJE?=
 =?utf-8?B?SDNXRlhMeG44b0FRcTE1L3JpQmFVK296VlgwMjRIZ3ZyWVBLbi9hVW9SZmc5?=
 =?utf-8?B?ZTgrMlhOY3BFellGSHdIQVVCY3lIT1ZZczNxeW41MnNpUTlDRHFRQmQwaklQ?=
 =?utf-8?B?QkpRZ3NwaUZhY2JEU3VZMDZaVm4zODFTNVI3R0dFc3dZQVQ2Sk9EQVh4eHpO?=
 =?utf-8?B?T3BKQ3NHR1R2RGxrTnZtSTdTdWI1K3hHSWVDSElKbnhndzhxcDVwRkozSTNw?=
 =?utf-8?B?U1MxWS9SY1QwKzgzRE1rSDdoajRHTTNmc0hRd2lnWXpYenVnT1NBVklZYm5n?=
 =?utf-8?B?SHJvK2s0MHFnYnRMUVNPU3AwaXZqc21aWDJtVzgvcXBHWmVXa2dCazBldWEw?=
 =?utf-8?B?YW9sLzRtVDVpaEJXTGJYOHZUanRRVHRLTkM0RER0TmhiYm5zNitYcTV5Yis4?=
 =?utf-8?B?MkVxRzNYTFg3cDk4QmFHOWZ1aUVSbllMdzZPYWdlQnhqeHoySGIvS0lOM2Ri?=
 =?utf-8?B?NE95N2JSMXlqYjRwTXJoMUF4cFlRWnEwVktTUTRNV2VOZUs1bmJXa1dhZmFR?=
 =?utf-8?B?aFo1QTBhUTFsdERoYThvaXpMVmRwcG9jaHBndnN3c3YrVlprK3pHM2FUK01t?=
 =?utf-8?B?cGZXYTVzRTlwZTRLZUxmL1hiWXRvd3owWC9xZ0QyQ0d0UjVYR0JUMFlPNXdL?=
 =?utf-8?B?Ky93Lzk5YVN5QnhFVnJUVkxoMHJSa2g3ZVkrMy9aRkQrakpnckgycUFOWm9j?=
 =?utf-8?B?aVBOcU9UcTQ0Y0tvYnYrRUE3SC9EMStsQ2YvRG5ON1JUWDZmRHp1dm1QeWh3?=
 =?utf-8?B?WXg0T2p3SEM1WkpadXhuMHZES0xTOFc1eFVEY2RPSGRML09xaWV0WWt3SWE0?=
 =?utf-8?B?UWF6ajFIYUZrQnA5WldCaHdvd01LQlorWGUwNlhBRkpXZEFrOFNkTUpYR2p4?=
 =?utf-8?B?alZWVzk5aVFwbCtEbjNVS2hDZkt3WVVGYWJxZ3Q5VUlkREpaQ1BIZmxpdFNn?=
 =?utf-8?B?aDJ0UDF0eE9CUEpWSWxyMjc3NnJaOXlGSlZKNDZKcXR5SWZuZEJNU0F1enNt?=
 =?utf-8?B?VUZ2SHo1Nll0UlVrOTVGbTVqYXU3eWVVUVNGUTZrc0dpUHRjR3VXUVlnZGs3?=
 =?utf-8?B?MmRiZVFNR1RLVVczTktaekp6MHRhNXFDZXVqNTdZMzlDYllVK0w5VVAvTnow?=
 =?utf-8?B?bnRma054QmlvMmdBZVpMSmEvK1l0dEpBUlFIc1Y1VFpKcUFMWnpUNWVEalJq?=
 =?utf-8?B?MW80ZlJteUJRQW1DNWZOQzlYYW9PdE5qUy82THpsY1lsdUU1dGdhaDlNOXRm?=
 =?utf-8?B?N1Q0eW9qVHhqYkY5N2Z5aGU0dmlaSjdjeURxb1B5U052bkhuYzFLb3B3WHls?=
 =?utf-8?B?bzJMU2M2eXdSakRkVS9PcE9LakFkL0cwQUpPNzYwbXVSZFh1d2Z1SEUyajA4?=
 =?utf-8?B?b09FVWRJeml6T0RlVlhTb2tWQ3pFRUVCWSthdVFHM1pIV0JmeHhzdzBRb1Rn?=
 =?utf-8?B?ZGF5Y3JJbXRKYXh3YnMrbDBpanpjRWh0Q1g5UXVTeHlna0F1czJ2VitiVnFp?=
 =?utf-8?B?L1cxYUQ1bVJkY1hERHZSY04yeElYSEZCTFRabnRFMVNhOEo1UVJGRG9FYWhZ?=
 =?utf-8?B?ajUxbkhpbUE5amptSVEybmp4VzkveXZNMlVpNzJlU3NGc3ZEcDJYQ2lMWTVp?=
 =?utf-8?B?OVF4SkdvYURxK01Ya0JrU2xlMkhPcHNxeXNVV3VHdFZhdHFNK3pEOTIzekJk?=
 =?utf-8?B?UTNLZXJnTklGNVZOaTFRWmNuaFBnMWxIWW9GV2VNcTI0ald3MXB3R2czOG9I?=
 =?utf-8?B?andzM1MwQ3Y5bmxYZEduQjRYdGhxZ3hvcWRLWTFhQTBOMThNbCt4N2RQUXpo?=
 =?utf-8?B?aUlXU1luYVp1cXFUWHNnclBjZXhLYUVmdE16dnllUSs0K3J5eDZDaW0za0I2?=
 =?utf-8?B?WkdwVkNTbVd4cjJtV0dDRjB3OUxZQWhjZUtTdGFlWGhoaEowTVNaYitpVmNF?=
 =?utf-8?B?eGk5c3ArLzlzK1VyYjNnZDlYUVR6aUczd0prV0E0NFdvUjNyQTQ2bWgwVGw5?=
 =?utf-8?Q?14Nc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8014DACAC8BBB4EAEF85B4896818FF1@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501feb1b-742c-4132-3ab7-08dc159c3750
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:33:06.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78GncKdQbhfViL6Fl8QfhT8HKDCWtfJjHMjOAAB97FMI7ZWi555ZKxAgEvGK87nv9rYkXcAKEf9Uv4vkGpOb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzEyIDE3OjQ0LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPiANCj4+IEZyb206
IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+IFNlbnQ6IEZyaWRheSwgSmFu
dWFyeSAxMiwgMjAyNCAyOjU1IFBNDQo+Pg0KPj4gT24gMjAyNC8xLzEyIDE2OjQ3LCBQYXJhdiBQ
YW5kaXQgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5D
aGVuQGFtZC5jb20+DQo+Pj4+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAyNCAxOjU1IFBN
DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDIwMjQvMS8xMiAxNjowMiwgUGFyYXYgUGFuZGl0IHdyb3Rl
Og0KPj4+Pj4gSGkgSmlxaWFuLA0KPj4+Pj4NCj4+Pj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEpp
cWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0
IDE6MTEgUE0NCj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBIaSBhbGwsDQo+Pj4+Pj4gU29ycnkgdG8g
cmVwbHkgbGF0ZS4NCj4+Pj4+PiBJIGRvbid0IGtub3cgaWYgeW91IHN0aWxsIHJlbWVtYmVyIHRo
aXMgcHJvYmxlbSwgbGV0IG1lIGJyaWVmbHkgZGVzY3JpcHQNCj4+IGl0Lg0KPj4+Pj4+IEkgYW0g
d29ya2luZyB0byBpbXBsZW1lbnQgdmlydGdwdSBTMyBmdW5jdGlvbiBvbiBYZW4uDQo+Pj4+Pj4g
Q3VycmVudGx5IG9uIFhlbiwgaWYgd2Ugc3RhcnQgYSBndWVzdCB0aHJvdWdoIHFlbXUgd2l0aCBl
bmFibGluZw0KPj4+Pj4+IHZpcnRncHUsIGFuZCB0aGVuIHN1c3BlbmQgYW5kIHJlc3VtZSBndWVz
dC4gV2UgY2FuIGZpbmQgdGhhdCB0aGUNCj4+Pj4+PiBndWVzdCBrZXJuZWwgY29tZXMgYmFjaywg
YnV0IHRoZSBkaXNwbGF5IGRvZXNuJ3QuIEl0IGp1c3Qgc2hvd24gYQ0KPj4+Pj4+IGJsYWNrDQo+
Pj4+IHNjcmVlbi4NCj4+Pj4+PiBUaGF0IGlzIGJlY2F1c2UgZHVyaW5nIHN1c3BlbmRpbmcsIGd1
ZXN0IGNhbGxlZCBpbnRvIHFlbXUgYW5kIHFlbXUNCj4+Pj4+PiBkZXN0cm95ZWQgYWxsIGRpc3Bs
YXkgcmVzb3VyY2VzIGFuZCByZXNldCByZW5kZXJlci4gVGhpcyBtYWRlIHRoZQ0KPj4+Pj4+IGRp
c3BsYXkgZ29uZSBhZnRlciBndWVzdCByZXN1bWVkLg0KPj4+Pj4+IFNvLCBJIGFkZCBhIG5ldyBj
b21tYW5kIGZvciB2aXJ0aW8tZ3B1IHRoYXQgd2hlbiBndWVzdCBpcw0KPj4+Pj4+IHN1c3BlbmRp
bmcsIGl0IHdpbGwgbm90aWZ5IHFlbXUgYW5kIHNldA0KPj4+Pj4+IHBhcmFtZXRlcihwcmVzZXJ2
ZXJfcmVzb3VyY2UpIHRvIDEgYW5kIHRoZW4gcWVtdSB3aWxsIHByZXNlcnZlDQo+Pj4+Pj4gcmVz
b3VyY2VzLCBhbmQgd2hlbiByZXN1bWluZywgZ3Vlc3Qgd2lsbCBub3RpZnkgcWVtdSB0byBzZXQN
Cj4+Pj4+PiBwYXJhbWV0ZXIgdG8gMCwgYW5kIHRoZW4gcWVtdSB3aWxsIGtlZXAgdGhlIG5vcm1h
bCBhY3Rpb25zLiBUaGF0IGNhbg0KPj4gaGVscCBndWVzdCdzIGRpc3BsYXkgY29tZSBiYWNrLg0K
Pj4+Pj4+IFdoZW4gSSB1cHN0cmVhbSBhYm92ZSBpbXBsZW1lbnRhdGlvbiwgUGFyYXYgYW5kIE1T
VCBzdWdnZXN0IG1lIHRvDQo+Pj4+IHVzZQ0KPj4+Pj4+IHRoZSBQTSBjYXBhYmlsaXR5IHRvIGZp
eCB0aGlzIHByb2JsZW0gaW5zdGVhZCBvZiBhZGRpbmcgYSBuZXcNCj4+Pj4+PiBjb21tYW5kIG9y
IHN0YXRlIGJpdC4NCj4+Pj4+PiBOb3csIEkgaGF2ZSB0cmllZCB0aGUgUE0gY2FwYWJpbGl0eSBv
ZiB2aXJ0aW8tZ3B1LCBpdCBjYW4ndCBiZSB1c2VkDQo+Pj4+Pj4gdG8gc29sdmUgdGhpcyBwcm9i
bGVtLg0KPj4+Pj4+IFRoZSByZWFzb24gaXM6DQo+Pj4+Pj4gZHVyaW5nIGd1ZXN0IHN1c3BlbmRp
bmcsIGl0IHdpbGwgd3JpdGUgRDMgc3RhdGUgdGhyb3VnaCBQTSBjYXAsDQo+Pj4+Pj4gdGhlbiBJ
IGNhbiBzYXZlIHRoZSByZXNvdXJjZXMgb2YgdmlydGlvLWdwdSBvbiBRZW11IHNpZGUoc2V0DQo+
Pj4+Pj4gcHJlc2VydmVyX3Jlc291cmNlIHRvIDEpLCBidXQgZHVyaW5nIHRoZSBwcm9jZXNzIG9m
IHJlc3VtaW5nLCB0aGUNCj4+Pj4+PiBzdGF0ZSBvZiBQTSBjYXAgd2lsbCBiZSBjbGVhcmVkIGJ5
IHFlbXUNCj4+Pj4+PiByZXNldHRpbmcocWVtdV9zeXN0ZW1fd2FrZXVwLT4gcWVtdV9kZXZpY2Vz
X3Jlc2V0LT4NCj4+Pj4+PiB2aXJ0aW9fdmdhX2Jhc2VfcmVzZXQtPiB2aXJ0aW9fZ3B1X2dsX3Jl
c2V0KSwgaXQgY2F1c2VzIHRoYXQgd2hlbg0KPj4+Pj4+IGd1ZXN0IHJlYWRzIHN0YXRlIGZyb20g
UE0gY2FwLCBpdCB3aWxsIGZpbmQgdGhlIHZpcnRpby1ncHUgaGFzDQo+Pj4+Pj4gYWxyZWFkeSBi
ZWVuIEQwIHN0YXRlLA0KPj4+Pj4gVGhpcyBiZWhhdmlvciBuZWVkcyB0byBiZSBmaXhlZC4gQXMg
dGhlIHNwZWMgbGlzdGVkIG91dCwgIiBUaGlzDQo+Pj4+PiAyLWJpdCBmaWVsZCBpcw0KPj4+PiB1
c2VkIGJvdGggdG8gZGV0ZXJtaW5lIHRoZSBjdXJyZW50IHBvd2VyIHN0YXRlIG9mIGEgRnVuY3Rp
b24iDQo+Pj4+IERvIHlvdSBtZWFuIGl0IGlzIHdyb25nIHRvIHJlc2V0IFBNIGNhcCB3aGVuIHZy
aXRpb19ncHUgcmVzZXQgaW4NCj4+Pj4gY3VycmVudCBxZW11IGNvZGU/IFdoeT8NCj4+PiBCZWNh
dXNlIFBNIGlzIGltcGxlbWVudGluZyB0aGUgc3VwcG9ydCBmcm9tIEQzLT5kMCB0cmFuc2l0aW9u
IGFuZCBpZiBpdA0KPj4gZGV2aWNlIGluIEQzLCB0aGUgZGV2aWNlIG5lZWRzIHRvIHJlc3BvbmQg
dGhhdCBpdCBpcyBpbiBEMyB0byBtYXRjaCB0aGUgUENJDQo+PiBzcGVjLg0KPj4+DQo+Pj4+IFNo
b3VsZG4ndCBhbGwgZGV2aWNlIHN0YXRlcywgaW5jbHVkaW5nIFBNIHJlZ2lzdGVycywgYmUgcmVz
ZXQgZHVyaW5nDQo+Pj4+IHRoZSBwcm9jZXNzIG9mIHZpcnRpby1ncHUgcmVzZXQ/DQo+Pj4gSWYg
Tm9fU29mdF9SZXNldD09IDAsIG5vIGRldmljZSBjb250ZXh0IHRvIGJlIHByZXNlcnZlZC4NCj4+
PiBJZiBOb19Tb2Z0X1Jlc2V0ID09IDEsIGRldmljZSB0byBwcmVzZXJ2ZSBtaW5pbWFsIHJlZ2lz
dGVycyBhbmQgb3RoZXINCj4+IHRoaW5ncyBsaXN0ZWQgaW4gcGNpIHNwZWMuDQo+Pj4NCj4+Pj4N
Cj4+Pj4+DQo+Pj4+PiBTbyBkZXZpY2UgbmVlZHMgdG8gcmV0dXJuIEQzIGluIHRoZSBQb3dlclN0
YXRlIGZpZWxkLiAgVGhpcyBpcyBtdXN0Lg0KPj4+PiBCdXQgY3VycmVudCBiZWhhdmlvciBpcyBh
IGtpbmQgb2Ygc29mdCByZXNldCwgSQ0KPj4+PiB0aGluayghUENJX1BNX0NUUkxfTk9fU09GVF9S
RVNFVCkuIFRoZSBwbSBjYXAgaXMgcmVzZXQgYnkgcWVtdSBpcw0KPj4+PiByZWFzb25hYmxlLg0K
Pj4+IFdoYXQgeW91IGRlc2NyaWJlZCBpcywgeW91IG5lZWQgdG8gZG8gTm9fU29mdF9SZXNldD0x
LCBzbyBwbGVhc2Ugc2V0IHRoZQ0KPj4gY2FwIGFjY29yZGluZ2x5IHRvIGFjaGlldmUgdGhlIHJl
c3RvcmUuDQo+Pj4NCj4+PiBBbHNvIGluIHlvdXIgY2FzZSB0aGUgaWYgdGhlIFFFTVUga25vd3Mg
dGhhdCBpdCB3aWxsIGhhdmUgdG8gcmVzdW1lIHRoZQ0KPj4gZGV2aWNlIHNvb24uDQo+Pj4gSGVu
Y2UsIGl0IGNhbiB3ZWxsIHByZXBhcmUgdGhlIGdwdSBjb250ZXh0IGJlZm9yZSByZXN1bWluZyB0
aGUgdmNwdXMuDQo+Pj4gSW4gc3VjaCBjYXNlLCB0aGUgZXh0cmEgcmVnaXN0ZXIgd291bGRu4oCZ
dCBiZSBuZWNlc3NhcnkuDQo+Pj4gSGF2aW5nIFBNIGNvbnRyb2wgcmVnaXN0ZXIgaXMgYW55d2F5
IG5lZWRlZCB0byBkcml2ZSB0aGUgZGV2aWNlIHByb3Blcmx5Lg0KPj4gRXZlbiBhcyB5b3Ugc2Fp
ZCwgdGhlIHJlc2V0IGJlaGF2aW9yIG9mIFBNIGluIHRoZSBjdXJyZW50IFFFTVUgY29kZSBpcw0K
Pj4gaW5jb3JyZWN0LCBhbmQgZXZlbiBpZiBpdCBpcyBtb2RpZmllZCwgaXQgYWxzbyBjYW5ub3Qg
Zml4IHRoaXMgcHJvYmxlbSB3aXRoIFMzLg0KPiBZb3UgbWVhbnQgRDM/DQo+IA0KPj4gQmVjYXVz
ZSB0aGVyZSBpcyB0d2ljZSBkZXZpY2UgcmVzZXQgZHVyaW5nIHJlc3VtaW5nLg0KPj4gRmlyc3Qg
aXMgd2hlbiB3ZSB0cmlnZ2VyIGEgcmVzdW1lIGNvbW1hbmQgdG8gcWVtdSwgcWVtdSB3aWxsIHJl
c2V0DQo+PiBkZXZpY2UocWVtdV9zeXN0ZW1fd2FrZXVwLT4gcWVtdV9kZXZpY2VzX3Jlc2V0LT4N
Cj4+IHZpcnRpb192Z2FfYmFzZV9yZXNldC0+IHZpcnRpb19ncHVfZ2xfcmVzZXQpLg0KPiBBIGRl
dmljZSBpbXBsZW1lbnRhdGlvbiB0aGF0IHN1cHBvcnRzIFBNIHNob3VsZCBub3QgcmVzZXQgdGhl
IGRldmljZS4gUGxlYXNlIGZpeCBpdC4NCkRvIHlvdSBtZWFuIHRoZSBkZXZpY2VzX3Jlc2V0IGJl
aGF2aW9yIG9mIHFlbXUgc2hvdWxkbid0IGhhcHBlbiB3aGVuIGEgZGV2aWNlIGhhcyBQTSBjYXA/
DQpPciBqdXN0IHRoZSBzdGF0ZSBvZiBQTSBjYXAgc2hvdWxkbid0IGJlIHJlc2V0Pw0KDQo+IA0K
Pj4gQWZ0ZXIgdGhlIGZpcnN0IHRpbWUsIHRoZW4gc2Vjb25kIHRpbWUgaGFwcGVucyBpbiBndWVz
dCBrZXJuZWwsDQo+PiB2aXJ0aW9fZGV2aWNlX3Jlc3RvcmUtPiB2aXJ0aW9fcmVzZXRfZGV2aWNl
LiBCdXQgdGhlIFBNIHN0YXRlIGNoYW5nZXMgKEQzIHRvDQo+PiBEMCkgaGFwcGVucyBiZXR3ZWVu
IHRob3NlIHR3bywgc28gdGhlIGRpc3BsYXkgcmVzb3VyY2VzIHdpbGwgYmUgc3RpbGwNCj4+IGRl
c3Ryb3llZCBieSB0aGUgc2Vjb25kIHRpbWUgb2YgZGV2aWNlIHJlc2V0Lg0KPiBUaGUgZHJpdmVy
IHRoYXQgdW5kZXJzdGFuZHMgdGhhdCBkZXZpY2Ugc3VwcG9ydHMgUE0sIHdpbGwgc2tpcCB0aGUg
cmVzZXQgc3RlcHMuDQpCdXQgaXQgaGFwcGVucyBmb3Igbm93Lg0KSW4gY3VycmVudCBxZW11IGNv
ZGVzLCB0aGUgYml0IFBDSV9QTV9DVFJMX05PX1NPRlRfUkVTRVQgb2YgdmlydGlvLXBjaSBkZXZp
Y2VzIGlzbid0IHNldCwgaXMgaXQgYSBidWc/IEl0IG1lYW5zIHRoZSBub19zb2Z0X3Jlc2V0PT0w
Lg0KDQo+IEhlbmNlIHRoZSAybmQgcmVzZXQgd2lsbCBhbHNvIG5vdCBvY2N1ci4NCj4gVGhlcmVm
b3JlLCBkZXZpY2Ugc3RhdGUgd2lsbCBiZSByZXN0b3JlZC4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpKaXFpYW4gQ2hlbi4NCg==

