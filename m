Return-Path: <virtio-dev-return-12126-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9534AC77B6F
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:59:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 05AFC419AC
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:59:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F01FB9863D8
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:59:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E52D098636D; Tue, 11 Apr 2023 13:59:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2E7998636E;
	Tue, 11 Apr 2023 13:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6387Nb/3Sx9PLZfPoCbewb7a6cXdhzMUBbDLkDaNLn4EUuOQ/2loEV7ZGB08yXYfDx0l0VIoT1vIvBnWiifoVCFlqUkF+6BneG/6FeNmQh/7LJeCg0N74hDSQjqDNaqInqBQP91MSl29f1FWDXKzPfUWa4G79zYVuRt9jKdDUGXeD40mbEUGaybEZyw+ow1Hkft54SYPa0XzSQcSNFpBXa18Qjo7ZMCKc6xIf4Hrhqhnb1FavU5bcsA49JTlHI10qIh+M0W7wAi8+bRDLltOgSEB/1tA/tiCnLN297iww6cgwAW+ckbl5nPxeLtjyOI8U6WHwTWKEfmFtXh5gmA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRVd1gr68NES1lZfcILJ63pVYOkFeDGwbvpVYZxWTUI=;
 b=elnXQ7nLESxEbGZo4lqBiKBTgof89NXpFDzta83DBUWnPRfhJx2PWNN50oR1Pd20mtlP/fDdepr6jiv0nm3Z7VvXXDVP09fhwu14S2xAdStYnkp5Y/yXGS/gOY5NX+uVPl0+7k0XyoLq+FsLIHKRCGrb8wKFDjBDzC4ePM9lUMozuy+8r0wQH4lzcfe/gbVxNPM4cguuqzPcOyRr6ymkIOsJCanvX65Lha9wv1e8BTyIuSlz8Sys4spd94pOFpvxuyF2IKTFFXm4RrNgTs3tdctUKfUE3D70//hBoYPyXfDtDqOtfYCYOcvmC7Of+jrgL2mOy3Hn+DNRy85ndaL8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability
Thread-Index:
 AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8j0vmAgABQjgCAAA6TAIAALr4AgAEQlICAAE50gIAAI2mAgABRHmA=
Date: Tue, 11 Apr 2023 13:59:38 +0000
Message-ID:
 <PH0PR12MB54818E4A171FC494B8708462DC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org>
 <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
 <20230410055947-mutt-send-email-mst@kernel.org>
 <CACGkMEsKLeJ1q3Vh8h2JYM=-RcrGd+31yR1Zsw0U=SRd1JZugg@mail.gmail.com>
 <20230411025646-mutt-send-email-mst@kernel.org>
 <CACGkMEui1ouE8DcXKkWUavToUT+vEP-c640vtw3BJBOSz5YTkw@mail.gmail.com>
In-Reply-To:
 <CACGkMEui1ouE8DcXKkWUavToUT+vEP-c640vtw3BJBOSz5YTkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7882:EE_
x-ms-office365-filtering-correlation-id: 27670e48-53cc-44dc-db61-08db3a94fd45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u062w7WeqAxU1l9DBEJPIyViOjoVKvj6s5Dck0kZaXISdCGSJJ+LeU8+5sXNZpgmGMNfCAYSyR58d6y79HYhL2pe/BmikYtSZXixNGmxuKaWSn0E2S9Ah9Sd0R3B1P9cWC87D66Bh3iArOSByOEoYmIQSlRFf8WRd0f80mcTJr0F38wVn2WA7exT7hw4WASwjJb78R6NwerzhkEwlx3XdVrzz9CK/PbPjJUu0oUuNRuOGdfsSoALN8D6sUtg8T0ZeyLcylpTGsYhDtYQLuAkFmw3Q+jfcRC+35pzFciBNDdwo/KDVry/P1LixgJfdvBvhQhcNlmnWdsyF0naWswG+9XiGJrffIYWLQg0vGosKvJWTVZeOZKXsAnAoZYo8CnfhU6x/9+xwsrWwSGL67Qy/3maGPtm6LofL5PzR4/Ybu5c4MdbvQcky4QEQo6Jme0+tFUAvjksVv6yj+YMkOrEJBLMsBB8SJroUUM1RCsIYrt4J72p00irs6NwxKY2RUIiVEdQvbH5uQjpPw5U8woRUUAhz0lDK20QO/lLOywq0UvQzWQmkxpO6ZdiyIBK4WozW3Mrcacq2QzW8jqHIN1xZHN7aFohP5SnZenJmrBCtxulCTid1my9yOJ33gCSoQkw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(55016003)(8936002)(52536014)(7696005)(4744005)(5660300002)(86362001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(8676002)(4326008)(478600001)(33656002)(38100700002)(110136005)(38070700005)(122000001)(54906003)(2906002)(6506007)(9686003)(71200400001)(186003)(316002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkpBZndKbm5Hc2x5aVNXdmtVVVBxUlBmR1AxV1NOd0l1THRiYmtCT2xsUTl1?=
 =?utf-8?B?OGVhM3QrWENOSVgwYmk5SExQRE9NaTZ6V2tTVFJkZWI0YVJCK1IwMGdCbVJL?=
 =?utf-8?B?S1Z2TlNvZldsaG4zMjgyeTBqOEdCWk82V2NGN0x0cVlrMjE3VmRpUGhvSmYy?=
 =?utf-8?B?VG90NklLOXg2ZU0zMmwzWTR5K2g1aWhzYVF0dVAwbGdDRjVjV1VwcGw3Tm5h?=
 =?utf-8?B?YmNOOGZBMG9KU01LT3BkM2lJWUF0NFRrMEN1a1RRbWdKS2ZrclpjaWZkbENq?=
 =?utf-8?B?VG1aNDY5c05RckNZOW82NmxHNFJnditmSWJpNVorRzdTS29FYzBPTmZob0Yy?=
 =?utf-8?B?YTltYUpGL2ZmODBEMXBqbkVjMEhiL3E1MTlRZXdvcmRvVG5ZUW0xWktaUjYy?=
 =?utf-8?B?YThRUFcwYjlPVko4QU9ZMzJRd3BhVG5TT3MvczJZOVB2OEN0dXdNRERBdVBU?=
 =?utf-8?B?YVp4bEZoYXQvcXRYSFM3OHg1S0VkSXhHNjVRRE8xcExJUzVwWXdGMG5RNG1Y?=
 =?utf-8?B?MnlPN0dVWEY3OTdaeVQ0UVZma2djWGtwcWJFUUtBMWtyZFlHa2Q0d2RJM0xY?=
 =?utf-8?B?czFleUZJNmk5N1ZUM2U3dENrMytLdkphalFSL1B4V0w0Z3IxWWRYdWc5K1NI?=
 =?utf-8?B?cVRNWWM1UlRqdWY1eWlGWUorR3hJUFZqTW9iSlozUjJiSzdtcnQxZkR1Z3lo?=
 =?utf-8?B?ZTJLbytHMHM1TXo0b2g1TWhURWFZMUdyMVBvbUZOcTUzQzFBR0x3UlRRWGhP?=
 =?utf-8?B?UUpSV2lrc0d2eCtORnlyOWVtcTVJSWFvUVRpTGtGZkZxKzlKYmN4MW1jU3lT?=
 =?utf-8?B?KzNXeitTY3paS0o3K3FtS0lNcUJjMXhRVTlXR091QTE2QmNOYk5uZk9hR2V1?=
 =?utf-8?B?M2IvczdKRStyVk5TWGJxNWpRYnRaN3lrelNBYnRORkJ3b3JyZlpYU2dWVmdC?=
 =?utf-8?B?bVBkUEZMNU5HY1d2MnU2NXk2T1FjeDE2VGs1MmM3aVVqSlByc2lreVdDSkJk?=
 =?utf-8?B?WURkeFA2TEhrOGlwaHNyeGlrNjZVQzRXeDZoZ2xHUWFmSjM3QldFcmdIanZ5?=
 =?utf-8?B?V29NdG5zeW5tendLR3o2Kzh6MkdCNlE5Wm9VenNxcGRQc0tSakxUNG05c1ly?=
 =?utf-8?B?dkMvalRYczQ5RE1IL0Z3MDNGUFFobTF1ZUJLU2Z1cmRqK0x4QnVGR1c1VzFm?=
 =?utf-8?B?RVVCbTBoVkoyUEJmVEdLaXVIMWQ1eVZPU0tWbVp2RlNscUNnUUMxd0FrcnVS?=
 =?utf-8?B?K2UrUnpPdm9oZElQQ0x2MStHQVd3SVkzelp3a1c1bmZTdXUwMFZkWnVnOUNU?=
 =?utf-8?B?dVQrczFjMmxRMlMwYmpZZDBGOHAxY3BtR09uNnlEMGF2R0ZLM3lpZTZKQjNx?=
 =?utf-8?B?SGpwaFRnYU81NDk0b3IxQWhyM0kvNzh0Rkk3S1lTUGw2MVdFajFOTzdDcVlM?=
 =?utf-8?B?MmZlZjhtUnZ1QnZNSm1GOHI1bjVUNUNrQ3dvQmpiTWFISEVDMGVoNFNMTzRX?=
 =?utf-8?B?RHNJdW51MWFRcE0xUzlmMlZHY1d4clMyK2Z6a3lhNGRBNEkySnNjK2xXSEFq?=
 =?utf-8?B?RVJUdUR6OENqYzR0bXhocEtZaEl3eGlBdndtdzBicHJjek80aWN3Q3ZDRHBY?=
 =?utf-8?B?aFgxNjh4Y0xOcDRHY0NhMzgrNE9nd01kaERDZHpLdU5YRmdySC84TTVjSnI2?=
 =?utf-8?B?M1BwRzdVVUd4TXZQc0tPMXFyQ21mOCtqMW9KR3g4K0l6MzQyTUhoSlNVZldr?=
 =?utf-8?B?YTczNUo3WUlkblVFUjVNaEhsTEYyT2s2dEVSMytneUdmajU0U3pHRk1LaFhZ?=
 =?utf-8?B?K2krZ05wMmI0dWpMbExVUWVqb25TR3c4dzMwU3VLbThUUlU2VmJWN0U1U2Jw?=
 =?utf-8?B?L2pPUmxueUFZL0d5QkRGNHljNHFzK2ZMa2IrcFpubUl6YVNEdHcxZHdZNVky?=
 =?utf-8?B?UU1OaVMxbTd5c3paMU03RXQ3bnhsa253NFVqbGMrbnJ3Tm9hdTZ1MStjRWNx?=
 =?utf-8?B?dXhMcFptY092UWNFekRuWFRvK0RZQkdxcDYrblRlMFl4dlp4NzVMZmNqRjF3?=
 =?utf-8?B?STRMeTlFSkkzRExBZlVuU0w4NWJ3bWNyVXRJY0hwTlFETlBIRnJaSVdlOWVG?=
 =?utf-8?B?ZWoxTmZOeUV5M0x0RFNuNTlmdE9aQk5Vb3k5NDdnTHgwT3NBbG9ENGppQllj?=
 =?utf-8?Q?EreDgROD9aWdNjPxD4OCFmw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27670e48-53cc-44dc-db61-08db3a94fd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 13:59:38.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aI9jNE+BV0456Cf5GunFePqY2VRHwiuCJFuQiBB8P5LtFl/Knf/29qKs90isAW4PugZan2jJlFIMR8GIdD/Ahg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882
Subject: RE: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVl
c2RheSwgQXByaWwgMTEsIDIwMjMgNTowNyBBTQ0KDQo+IFRoaXMgaXMgcG9zc2libGUgYnV0IEkn
bSBub3Qgc3VyZSBpdCdzIHdvcnRod2hpbGUuIFdoYXQgaGFwcGVucyBpZiB0aGUgZGV2aWNlDQo+
IHB1dHMgYWxsIGNhcGFiaWxpdGllcyBpbiB0aGUgZXh0ZW5kZWQgc3BhY2UgYnV0IHRoZSBiaW9z
IGNhbid0IHNjYW4gdGhlcmU/IFdlIGNhbg0KPiBwbGFjZSB0aGVtIGF0IGJvdGggYnV0IGl0IHRo
ZW4gZG9lc24ndCBhZGRyZXNzIHRoZSBvdXQgb2Ygc3BhY2UgaXNzdWUuIFRoaW5ncw0KPiB3aWxs
IGJlIGVhc2llciBpZiB3ZSBhbGxvdyBuZXcgZmVhdHVyZXMvY2FwYWJpbGl0aWVzIHRvIGJlIHBs
YWNlZCBvbiB0aGUNCj4gZXh0ZW5kZWQgc3BhY2UuDQoNCisxLg0KRHJpdmVyIHNpZGUgY29kZSB0
byByZWZlciB0byBleHRlbmRlZCBwY2kgYXJlYSBmb3IgbmV3IGNhcCBuZWdsaWdpYmxlIGJlaW5n
IGV4dCBjYXAgaXMgZmFyIG1vcmUgY29tbW9uIG91dHNpZGUgb2YgdmlydGlvLg0K

