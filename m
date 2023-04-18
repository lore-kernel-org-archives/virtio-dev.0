Return-Path: <virtio-dev-return-12268-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0ADC77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:30:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AAAAE86168
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:30:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2A2D986421
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:30:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 96C129863EE; Tue, 18 Apr 2023 01:30:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8387F9863E1;
	Tue, 18 Apr 2023 01:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwGjzFK7G7xhW1bt4y7UI0g4sVZDDaYrCrOrhBMXPwyfGYbl5ROLXyMiDeHRHcqSB+026fEofwLLfsN8YtH5gXpto9CHNll/H3xjZv+ytRqyChgTU1CrvdZ9p4qWCJT0lW46D8UEQ8SKclQGzUY7ttogTuJKs53cR1gStZB94eIkymjF9HwBe713ylaY/jM+rQNxxRxqkoSRAuqSzZUBTWA6rE+fvRBKmFaFlZP3Mz1D1EKFWm42S98iCVJq70tx2ZM5J5QldHSqO55d7wygjrTg19HTuOXMrGR0u2o+SOeWVmHN/rAGJxIekH0rFg7OenIJySya4zE7ohiE78nEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXZHknVztMX2uIQNKih/BiWn+tk2+pqRWxrUprmNnyc=;
 b=bVS9tAn/RYNcmHo9mOhpN7R5NyXTeenM7FwtRCv7/AsfQG9u1SuP7+xG6CHl5via/+0RCLi2R8C5L+/+e7TaXwAohAEGurzIAHUUWK/h/UMYvxYijhApjLdncty55Ftxaj+ML+tSsvverYbdyXhlRULe5NG6KUb7q/anpc4MbXknvIHc4eGIWjG9Th7+5/7pkq1TC1J+ndIDmCypzpbVSaT3kSKSMsthS+rtQ4Y4MIoh4TUx5Zeyj3vlCqDXJG4XLABci4Yt92v3HwanItRaeWQ4Fjcc6lYW6kAxlwSPWpORKgr/WBxix5NeVJIykiGhnnxGRYSxQOdWeGtqAMlkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQgAAGhACAAACJcIAEsiqAgADky5CAADloAIAAAFbggABFZwCAAA58oA==
Date: Tue, 18 Apr 2023 01:30:43 +0000
Message-ID:
 <PH0PR12MB548113626CD6C7B2F8589042DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417162618-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481710854882449008F28BDDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvPv7eH3+cggcCVZvRCqkNCh_CX+6azNJtdJUDxjjAjwg@mail.gmail.com>
In-Reply-To:
 <CACGkMEvPv7eH3+cggcCVZvRCqkNCh_CX+6azNJtdJUDxjjAjwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7731:EE_
x-ms-office365-filtering-correlation-id: e0637a3c-1a03-4c2a-5d54-08db3fac8715
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0LGg57qbAHj1+028b9XzD6yyQn6SVDEvuBaQqYmjsDxlyzucSnnOXqni4TWbPpMdH/iy3TM3NVWXvnJSus5+2hwXSW5tnujQBL7rmDiP5aG0NQC+Py8+DERFuhwWsB9DmbIneWj2fL5iQ8AmQKf+Nyhzr+h9wEWUrBMKpfYeq6pR/OxgBN8NQ4ZSQfq4FrM6qUmyEG6rO0OFsU8cg3S1qS/Yi+Je4r/MhaLX3kdjo3d9Fp7tViVcqUtz7D8nfqsNRNSTAJDbJcmKmSLd02l27Mns+TgN0b+1dUQOqhZQ/48wTBYueJukQbe/K/Ogqv2M5ECslzqcrsA4iRQRWiCiz8PgZEoCbidu8OqXXhDf832fwfk6Cv70lc15nzwsfgkFztunv33mcgr33w9odmLDvHWNYgDXcmAl+93JLfGHQskU1aZ32Yr7b0mWb08rlrabnzgtLl70dA5XXANpiVSPBMzndX/OhtwAOUfs1Un1j8lZ8wwGJNcCjd/CnKMp2vbA2aoDLVgQciKZC5V9uL4f2bN+7pUBhW1/c4qgCMwJxsNHzve8VaDf/HDVr+57gccORZ1TWyEoMhZG4inCRM/tvW1Bl1DaRj6d/NjB/G+72B8Ww1BjgxqJIWdKkldr4xPD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(26005)(186003)(9686003)(41300700001)(6506007)(54906003)(86362001)(83380400001)(55016003)(6916009)(4326008)(316002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(4744005)(2906002)(8676002)(8936002)(7696005)(122000001)(52536014)(33656002)(38100700002)(38070700005)(5660300002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWk0TzUzRWVtckxWNGpyNHV3STZvSnVRNVhTWW1hY2EyRy9VNkZpeVhHSkFL?=
 =?utf-8?B?ZFY0NUxjZS92RXFBVTE4SWJMQjQzVytqVEJXNldHZjkxcmxCeEFidVBZN29v?=
 =?utf-8?B?cFBtRzMzWVNDWVdyaXY1MVdKaHNURXR3KzFhMVhlMFpPVGtpU01vQUlRQ1pn?=
 =?utf-8?B?ekMyTVQ2bSsxSmVnRUFQd2FWc2J5aWRieEc5N0VKcVhGQXE1a2RwWlpaMDdk?=
 =?utf-8?B?Rk41R25Hd3loZTg2SXJwLzZQY2RtQmJTRkxZbUlMRGlvL2xZRTFkMFB6TTNG?=
 =?utf-8?B?c29Yd1VUUTBuN0FzMmtOczVKMTNCbGZNM2k0OEZXSUFaRDU1S1JSSVpWOVQ2?=
 =?utf-8?B?WFFwL0F0WWhFZGkzcEtGMGwrWlBKdUtxR1BkTDY5N21WeG42Sjc0b0lsUThO?=
 =?utf-8?B?cUpFZDFtOFNDZzk0T0tuQXBLTVp0c2lsVHNJNGttQmVZN2lPdldLSnpuUDlO?=
 =?utf-8?B?QmtaOVk0dU1HN240b0d2RWNCeXMzZDlybWE3TzFqTU81V0l0aUZVZ09rOGpF?=
 =?utf-8?B?TkxVUWp1SExXMVlQYkJVMXJmUmVoUFR4dVpTYndCVG9XVW00VG44ZFIxNkRs?=
 =?utf-8?B?aUV3dG5GRGhLZ1Z5NFVyQ2pWN2FuWHJrdWF4MHFvZnB0YmFvVTJDOHBQYW9K?=
 =?utf-8?B?eXNLOGl5dXlNaHRWOGwyT3R0TWwzRkhIQzduQ0FlMkk5ZEc2K1J2czI1SDVJ?=
 =?utf-8?B?NjV4VktES3VWSVV4OGx3bWNkTDg1VG9Nc3N5bG9sZmlKMisxSEVKQktmam5E?=
 =?utf-8?B?OWZLWTNOS1Zwak9GcVkydnhGL2FCZHoweGlORERORXZma1VqVzBKendOUVZR?=
 =?utf-8?B?VzR1TXZpaWI0TEt6M1M0Wm42OVZaN3JaV2pTajlaQzFhdG9SWTdFMllPVkRr?=
 =?utf-8?B?RGFmSUZJVE5jenRJbDFFS0RmWlBnUkFNb1VLTG43OStDSTFYNk9PWU5YOVBz?=
 =?utf-8?B?TmFNclZWejdEa1hHVDA2K2prREU0eERvL09CZ1Y4a2xSR0xXVElZd1p3U0cx?=
 =?utf-8?B?T1BkK0pXUEpDc09oTGtidDhNdG1aaXR1ZmlHbE5WS0RBZDRwSHVhOHZuai9P?=
 =?utf-8?B?SVNmRmRBU1RwUlpUUEl2NnYvWjBERmE1RkRrei9uMTBseVM3YUhLaTcyUVZL?=
 =?utf-8?B?N2ZWU3pOWGRaQTdxSHEweWltUVZHUk5EbThZV3ZxeHVVSmVWSzV1UmFQNGpu?=
 =?utf-8?B?TFFZcHg0aHJWWkV1ekQ2VmxVQ2cranFZdkl3SDhVU1VLMVR4ays3elpOeE8x?=
 =?utf-8?B?dGtmT2RHZEM1NVRhZ2RWSFkzMG9NcHlYS1VaT0l3ZEtpYVhYT3owMkdZa1ha?=
 =?utf-8?B?SFZteHcySGZrcUg1QUMrcXF1UmtyYjh2c25XUXcrU3loa0lwZUhWYS9PbVc0?=
 =?utf-8?B?TVdoaDZuYUVxUHNwVWFsbitib3FIK05wZzREczFTckluMnFLSTJkNGZySTl1?=
 =?utf-8?B?S2xWS1owN0U2ZTlmZFhRWFBNMy83dEVSamhyKzhyaDBEZ2pNbEFQeS8zSG1X?=
 =?utf-8?B?bTM3VVJ5a1VoV0V0eFFLQ0JVdnV5dFUzZGNPbXdFRjZEUWw2NDBUa3Y3UkhR?=
 =?utf-8?B?a3J1OHhrTnI0a0FyekQ2bkJyTHR6N25kOTJwbXZ5Und6UEV4eWRoaHAydCsx?=
 =?utf-8?B?bklLbDNYRW0xQVlMRk43YXNIMEN4NDU1bXJ3WjlyNUhOaXYyWUd4aGdKYTFt?=
 =?utf-8?B?T1ZTTVBHTC82QzVIeDJlb2NnbVBkTkhpTVlXNE9OTGlDeVNGNFNsVVQ0L0dn?=
 =?utf-8?B?N0xDajdaZ3pLaXlGU2NsTFJnam5zb2tGMnRqbUtRamNvMWlQUmM5a24zWTZt?=
 =?utf-8?B?SEVDMnhKSkV0ZFp0YWpjbExiNnUzQlNMblgrZGtZNVdmZCs0eG9xbmtXU244?=
 =?utf-8?B?ZnhJeHV6RmhwY1M4eWt4OVJsREIvdzUyK3BuK0NYTXNlVW9VSngvelFxZlJW?=
 =?utf-8?B?MEpJaXcraFoyVzZ4QzYzdFF2aE03ZGZ0WjFJVkxJS3NsTXdlYmtKRTRhaWpH?=
 =?utf-8?B?MGdHVUt0QzZXNzljOHlPa2hFWnR5Q0F4dVQvK0R2QlZHVDlhVVY5VnVuVTZj?=
 =?utf-8?B?SkRPOXpMWW5aT2JTZTJPUzR5YWNleWdLSWtwYWNnaEtGT0RwclBQRlcwMDYx?=
 =?utf-8?Q?LOYc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0637a3c-1a03-4c2a-5d54-08db3fac8715
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 01:30:43.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsKjxGUXO0XxPUlvFB7yM8z8+xq8T7xACeSb1fV5nu01u+LsivmrGjO2MIxP+gz9cuf3ylilU6QSO0IE1E/YPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBBcHJpbCAxNywgMjAyMyA4OjM3IFBNDQoNCj4gPiA+ID4gRG8geW91IG1lYW4gc2F5IHdl
IGhhdmUgdGhyZWUgQVFzLCBBUV8xLCBBUV8yLCBhbmQgQVFfMzsNCj4gPiA+ID4gQVFfMSBvZiB0
aGUgUEYgdXNlZCBieSBhZG1pbiB3b3JrIGFzIFNJT1YgZGV2aWNlIGNyZWF0ZSwgU1JJT1YNCj4g
PiA+ID4gTVNJWA0KPiA+ID4gY29uZmlndXJhdGlvbi4NCj4gPiA+ID4gQVFfMiBvZiB0aGUgUEYg
dXNlZCBmb3IgdHJhbnNwb3J0aW5nIGxlZ2FjeSBjb25maWcgYWNjZXNzIG9mIHRoZQ0KPiA+ID4g
PiBQQ0kgVkYNCj4gPiA+ID4gQVFfMyBvZiB0aGUgUEYgZm9yIHNvbWUgdHJhbnNwb3J0IHdvcmsu
DQo+ID4gPiA+DQo+ID4gPiA+IElmIHllcywgc291bmRzIGZpbmQgdG8gbWUuDQo+ID4gPg0KPiA+
ID4gTGF0ZXN0IHByb3Bvc2FsIHNpbXBseSBsZWF2ZXMgdGhlIHNwbGl0IGJldHdlZW4gQVFzIHVw
IHRvIHRoZSBkcml2ZXIuDQo+ID4gPiBTZWVtcyB0aGUgbW9zdCBmbGV4aWJsZS4NCj4gPiBZZXMu
IEl0IGlzLiBEaWZmZXJlbnQgb3Bjb2RlIHJhbmdlIGFuZCBtdWx0aXBsZSBBUXMgZW5hYmxlIHRv
IGRvIHNvLg0KPiANCj4gUmlnaHQsIHNvIGl0IHdvdWxkIGJlIHNvbWUgZmFjaWxpdHkgdGhhdCBt
YWtlcyB0aGUgdHJhbnNwb3J0IGNvbW1hbmRzIG9mDQo+IG1vZGVybiBhbmQgbGVnYWN5IGFyZSBt
dXR1YWxseSBleGNsdXNpdmUuDQoNCk9rLiBJIGRpZG7igJl0IGZvbGxvdyB0aGUgbXV0dWFsIGV4
Y2x1c2lvbiBwYXJ0Lg0KSWYgYSBkZXZpY2UgaGFzIGV4cG9zZWQgbGVnYWN5IGludGVyZmFjZSBp
dCB3aWxsIGhhdmUgdG8gdHJhbnNwb3J0IGxlZ2FjeSBhY2Nlc3MgdmlhIGl0cyBQRi4NClNhbWUg
ZGV2aWNlIGNhbiBiZSB0cmFuc2l0aW9uYWwsIGFuZCBpdHMgMS54IGludGVyZmFjZSBkb2VzbuKA
mXQgbmVlZCB0byB0aHJvdWdoIHRoaXMgdHJhbnNwb3J0IGNoYW5uZWwgb2YgUEYsIHJpZ2h0Pw0K

