Return-Path: <virtio-dev-return-13362-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF87EB64DD
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:28:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B7CF81EDE7
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:28:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AAB979867D7
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:28:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 99CEC9867B3; Wed, 12 Jul 2023 22:28:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 841B49867B4;
	Wed, 12 Jul 2023 22:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4kQPCLhVLKMZlXMYyoh+12Jr9AOo7OlEyDW6BKfL2MM21lIABQkaZHY7LQfEs4FhKkG0SuOwjoN/UtCsMIvLrcmSAnVCYDTCSQdzccls2NC18u1hAwaFraLmFhKPRm9SVwvNbFNmUq1OWzZAZ34PMuDwhvxWDOTDa/AhOl9lsJsKk5zdRPLUEbzFHr5lv87y4M/nmXesHjU4NakAc+CwVQY1/AC70VIFurAZtl7FYAgOKLvXY2VCV5ksm8aSq0aQbe0oo+wY2izJLyIHfGcslSxqtpykVGEhPcErMpNoVo3N/LLGk7pwIO9YhJPR5PzW2gC9VF++i6oFfoLP4tsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF121V31XkClUARF3VcuHW9GQ7+oRKl/ZWPDCGyTbwI=;
 b=TVQ7cNfTUKB2p+OZG3crn0SQkH2bl3H0HBCOhoWamRVteDY7BnZkjMxqvzwK4qFs16Z3oah9Frg533TktOkcHB1oD7lPiblWyml7cV+hb4fD9+x2MmHZwjfneG2KGXh2n7NQ7L4xE/3NOCDN7DnaAMeEXe/zzN1xg6hfAviyAg0k1eyCatYQF9NDcJRQBSVdFH3ZCPD2e/5OFp7bvzBV+vCNf/Dbh+xB17kqLQ5lmh2STsYmZP7HjGyw4wJ0j2UnJxdC/D/+EkWsWgNkhfUvckwP0OAOxKmfyuluAZJP+YqcrccfPakYFN5l0DrZevGr2X5y8XIxomAZCym062vtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v21] virtio-net: support inner header hash
Thread-Index:
 AQHZrcLbGn+M0MXS/UagA7zKbS/v/q+2G4MAgAAA34CAAASegIAABOgAgAAHJwCAABjfgIAACBiAgAAYzSCAAF1BUA==
Date: Wed, 12 Jul 2023 22:28:13 +0000
Message-ID:
 <PH0PR12MB54812A7AB5704C4F337B3920DC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <87pm4xjp4t.fsf@redhat.com> <20230712082508-mutt-send-email-mst@kernel.org>
 <87jzv5jo82.fsf@redhat.com>
 <e0e2b21d-a7f9-fbf1-7d93-d142c7a7618a@linux.alibaba.com>
 <87h6q9jm85.fsf@redhat.com>
 <b1b03bfa-45ac-42b8-86d9-aaf47c4704e3@linux.alibaba.com>
 <87edldjgri.fsf@redhat.com>
 <PH0PR12MB548162D04BDB6E3AAD9F05B8DC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB548162D04BDB6E3AAD9F05B8DC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6049:EE_
x-ms-office365-filtering-correlation-id: 210bef98-d3b5-435b-5823-08db83274806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JvAE3x7yy6spD32QkU2G1Kz7aRrifrHoEKk0Q9drv1eUn7Eo7R1tyMtHuvUVrbf4vOLqOpfTckPJBIbsGeldWCRd7Lz59oaCfV1gacoRhyYeGqBnCvFu2ExrE1l6hydYCAbYweuoWI7drAOpPCzXHF0sg5vaPu1L1sYTrmwch8zmH735lSwpCKuF162G+t/xe548i0OZj/VVNkwc8YAq7Mje+/NuOnLVxDmUbEsJnJbpb05M/mz2ANWzfgFNAc/Zh42z1KwXUuiAGem0uHc3M/RGfsRDwcHrIK13tF7tyuMub4eg6y02VRJrTHF+/IDxJjFXDQw+u8id78UUmWkIkGjf16z/lXnqszMqtwzTiDtjJ/XRs4+B0eyaMkwj0wPVg4Tgr47Kkr8y1blMGfUBW1m3SCo4y2/OFbkyfxF89rCXeX91I8WR2WcviEN0zreZ+G3WV9CMq7z3nnK0Am6OAoJ+0lqKnwJzOfXCj2ucu03+UyzoUTsywyba0HxpdzO+3nl8NT//6niVRqbQpiwnjYvHpXo1OMzQPhu/rglORB/tB9IW1HAMUDjrtPvtIgz1/yp60skMfZiF4oRQTEEmBphSPBsgf48UQdphSRZKotqYsTbrPLzcpiG+Nb/6SAN5yzKzaxQQI38uggWnq9S4Ml23/TshSg0/atE7PfO+wUU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(110136005)(26005)(7696005)(76116006)(71200400001)(478600001)(54906003)(2940100002)(966005)(186003)(9686003)(6506007)(2906002)(4744005)(66946007)(41300700001)(66556008)(316002)(5660300002)(4326008)(64756008)(66476007)(8676002)(66446008)(122000001)(8936002)(52536014)(38070700005)(86362001)(33656002)(83380400001)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFhMdjhxZE4xd0dJdG5pSXplSTY4SzBtN2kySzFpR3RhTTZyOU9PVm5RQ3Ra?=
 =?utf-8?B?QUI0M3R1Nm1ZOWJlSDJxR0dlM2JqQXNHRWNSYktNM05LMWNqN1ZIWWh3ZEhW?=
 =?utf-8?B?UUdIWVc4QVV6ZTFFQ3B5bU9QaWs5aTNPeHdrS2E0bHZvMjRSOFFIWUVXa2oy?=
 =?utf-8?B?UFZvUzRSaTg5MVZFS05Kc2VGUkt1MGhTNXNIQmpaV1lEM0Z6QUFuVDJQM3Az?=
 =?utf-8?B?anlHenJoSzAyT0V2SUY1Zmp1aW4yd2N5YjFpRXlFK1hhSU05Y3ljajBJTHUw?=
 =?utf-8?B?N3JPQzkxWE11ZnhOUytFNnJIZHN5K3dTRVRYcTlIVm5XQzlabjZuaUw1ZXFJ?=
 =?utf-8?B?MzJsS29vVDhla0cwbk0xTFNEVytSOTd0M0xleVErcy9ULzdkeDdUSENuWHQv?=
 =?utf-8?B?SHNqR3FhV0E5OFhPT2N6UVkrWlBqWFpjVkFtU3ppSzBZanNkQ0FLQ3JLVmNw?=
 =?utf-8?B?MERkK2paQk9SWmN6Z3I1NUtyWFNUb1NibHhiZktWM2wrQktkNHJsWDVLZlM0?=
 =?utf-8?B?bnZFTmdpc0VwbmQwalE4SVArVVYyT1preTR0Yk9Bc3QxUGQ3N2hTYnd1ZFFu?=
 =?utf-8?B?UHJOc2EyUlVYTWUzMTZuZEFKY2dHclhmNVVoVEhSQVp0QnRKd3padjRxcXBO?=
 =?utf-8?B?bEF3MERCclRnSkFFLzRzUnh4dUNSSnBvcVYwK2UrbGJtTlRPa2Jsa0tuVUtH?=
 =?utf-8?B?ZG1SZ3Rjc28xNzNkZmZYcVNIQzBtQWc4YTN2a3ZiYUJHUExoOEJwVGdzWFpV?=
 =?utf-8?B?NjM4QTFtRzdIczU3SzlzcUsxdWNhSmhnK3RlK3hiTEdNcmRoeWMva0hIbCtx?=
 =?utf-8?B?cHpmMXVWN2VhVHBMQkVIVm1aYmdpaHpjcWRxa2kvUjRWbE9VckNSRlZZaXpS?=
 =?utf-8?B?cGFjOFpHdXk4U2JRRzF3QjA3OXpxblpsQ0dlVmJUU05uaXZCU09aVWhLV0RD?=
 =?utf-8?B?QlBzcEVPMk5vbFlqN3FoRkZVNmZuZjU1bkRCdjBDMm5xRzBQNWYvWEYxWWI2?=
 =?utf-8?B?OW9OTHppY3NJaFN1bkJqRWdxSjlnZHRvQ3BmRjJuNFliK0RBY3FLWWd0Z2la?=
 =?utf-8?B?UnNXc0w2VDNvQmhTbTA4WG9wN1hHRFlNT3J0MWtoTnN3amlTc2c4NzVRTDRI?=
 =?utf-8?B?K3Z5Ui9vVElnNllXMW41YllYV1BsMGZhSlZyaWkrUTMwRU5yMDN0RlFpa1hw?=
 =?utf-8?B?c0RIRGp6Z0R1NlpBS2pWcnRvUlFFVy9uRFBBbm84WEN5ZmQ3WHBUdFlicWhS?=
 =?utf-8?B?dkdCcUQzeWg2aGFic050Qkw2RWNOaDNGckVJUHp2bGs4NHZBQlJ4UUxJUkMz?=
 =?utf-8?B?TFhrc3RqcFM4b3IwLzR0cE01d1k0UnFKbldZSUo0cmxiK3cvd2Z3UnNEdGpw?=
 =?utf-8?B?KzFsci96VlpIdEVOQ2QvclFCUTJvMmtLQUNaT1hkcksrQVJMVHhPV3J4RU4w?=
 =?utf-8?B?SG42NXI0OHBOWGVFZWdOUlpkTGF0S2dGUitDMDJZU0J4emhZRnU0WXNHWFBx?=
 =?utf-8?B?eTlDWE9GZU54ZTJDM1VrczhWSTdYVnh4bEpscDJTWGlHWXJVSlF6L2Zub0xw?=
 =?utf-8?B?cFpJSFNSaVg1SERJS2lUb1JQYXFlN0wwUVdsVmxJSzBmZ3E4UXZBNmFTZDhW?=
 =?utf-8?B?bXBneGlSdk1xU09UWmpDVGNnQVZ5ZzltWWdFeVdhalZRNnZSZC80VHowNzRH?=
 =?utf-8?B?YVI3dWZnVnVobFlqN05KdUJLN0ZqOUZEeGdXSmN3R0pFOUJ2bFdGczZWU1Az?=
 =?utf-8?B?VlhDSkZ6VnJYd0FxVklIa0hKK2JBcWMrTGo0VGxtdGxad0RhTmZPZnd5d2RF?=
 =?utf-8?B?Z3F4V1FtVGxmN2pVL0lkbC8rd0xLaTdBN3lvbXI1SEJxcVl1MHJUaE1DWmNz?=
 =?utf-8?B?Y1MzMGdvb1RaZWsyaG1ENkcwMmRTa285QjRnSER2QnBXOEh3WWNLYk1DZWpl?=
 =?utf-8?B?ZE5idFV2YnplWm5rRXpIclRXRlZvOFBSc294cEhQT3pkZHNjc2dSd2RhTkd2?=
 =?utf-8?B?SXhHTWkxTHg1K01MOS9qT0VJZEJzUEU2ODIwZmNNMVJxdTZmV3pTSTY4dWlC?=
 =?utf-8?B?VGoxbmczZllKcXBJVXFDTUhkTzRBeGFtOTRMeG9DUjUxYTZTRFFZUkt6bFZq?=
 =?utf-8?Q?8LT0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210bef98-d3b5-435b-5823-08db83274806
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 22:28:13.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKAiq7n9gKFHZep0zPwYHifxG7CikGOJYXjxf1DlK1FCQ14gXCtjUOVNPzPqxGBIfiLyOjq3NUW4UUq4z/MDnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v21] virtio-net: support inner header hash

SGkgQ29ybmVsaWEsIE1pY2hhZWwsDQoNCj4gRnJvbTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlk
aWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTIsIDIwMjMgMTI6NTIgUE0NCg0KPiA+
IEknbSBhZnJhaWQgdGhhdCdzIG5vdCB0aGUgcHJvYmxlbSAoSSBoYWQgdHJpZWQgdGhpcyBhbmQg
c2ltaWxhcg0KPiA+IGNoYW5nZXMgd2l0aG91dCBzdWNjZXNzKTsgdGhlIHBkZiBnZW5lcmF0aW9u
IGlzIGFscmVhZHkgZmluZSwgYnV0IGh0bWwNCj4gPiBzdGlsbCBmYWlscyB3aXRoIHRoaXMgY2hh
bmdlIChvciBzaW1pbGFyKS4NCj4gPg0KPiA+IFtUcnlpbmcgb24gYSBzdGFuZGFyZCBGZWRvcmEg
Mzcgd2l0aCBhIGZ1bGwgdGV4bGl2ZSBpbnN0YWxsLi4uXQ0KPiANCj4gSSB3aWxsIHRyeSBpbiAy
IGhvdXJzLg0KDQpQbGVhc2Ugc2VlIHRoZSBmaXhlcyBmb3IgdGhlc2UgYXQgWzFdLg0KSSB2ZXJp
ZmllZCB0aGUgcGRmIGFuZCBodG1sIGdlbmVyYXRpb24gYW5kIGxpbmtzIHdpdGggaXQuDQpQYXRj
aCAxIHRvIDMgc2VlbXMgdG8gYmUgbXVzdC4NCkRpZG7igJl0IGFuYWx5emUvZGVidWcgZXJyb3Jz
LCBidXQgbW9zdCBzZWVtcyBsb2dpY2FsIGZvbGxvd2luZyB3aGF0IHJlc3Qgb2YgdGhlIHNwZWMg
aXMgZG9pbmcuDQoNClBsZWFzZSByZXZpZXcuDQpbMV0gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVu
Lm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDcvbXNnMDAxNzEuaHRtbA0K

