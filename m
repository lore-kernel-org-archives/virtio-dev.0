Return-Path: <virtio-dev-return-11747-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E092AC6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 03:13:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1890166D67
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 03:13:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13D1F9864A3
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 03:13:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 08AF79860C4; Thu, 23 Mar 2023 03:13:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7D3D983DE2;
	Thu, 23 Mar 2023 03:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps5hv2cMRRgTb7DaMlf8vnxv3B5e210sxBifptNrs79lnJzaQsxenmo8anfzfLJ0nJOVeQjHaKqjJH5NGmqbD5pM9JD+7AcPUT+A8NmefjOwhKDwq76jTEUNRi4hI8VxJMtYUX4z14fAqkH1TF/97TuQ61x6beyJoY3eDiOsK8/fal2xXOMfA3akpsQUUVL4RHWf8rSRiYGBemQoRsu9EwpBnxTV/fZzqUmLTIlwidM1yfVkVJ50VUNPFpHmdyq1bePS9hHmh5CrodDiBTFNXiMkp90knJ+VbAwLcsYjgaTAPraE8qjfc7KvGOBZzPhnMPA3qUvss2hFsq/PPAcXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5r+IEFILfu4lgpxnz1+qdi+qy4c+K3Qm4BVXUdmkMBg=;
 b=jrJbWp0VwksxRXICtFXgwLEbJfiWw5mlkudXPni/DIA6JEv7r6lXqW5xAIla5RDCohoF/3koQ0To8yOskCFpGAu6N+hlZzX+KDx9ee0wuoWs23lCTxh7HcG7GsaA3CrqR/MgzqIhqCD3eEgvNAwlnMwTKRS4CBO1659zeVwg/QJbuYwb7jR+vSULCS+sDpNsj5VAFP1IhmSCdijxrJ+QOhkpW4nHdG/51HropUkqQS6/3mFccNEOF4m/AtRLUJD6duIZwqvTTdLSNkIueSL3bSeB7Wwgut3DLtKzy+yfDy7nmuwQcOskfaxiv8RzizHVpWBKGpmDBMLlaXcyIVVZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
CC: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>, Yuri Benditovich
	<yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash
Thread-Index:
 AQHZWx29SoEdHy2EykmUgaDSd+Xmwa8EEleAgACJlwCAAD0HAIAAeYmAgAATKICAAV2mAIAAQP+AgACvmtA=
Date: Thu, 23 Mar 2023 03:13:30 +0000
Message-ID:
 <PH0PR12MB5481B877D417412CF94145E7DC879@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230320111840.64039-1-hengqi@linux.alibaba.com>
 <20230320144625-mutt-send-email-mst@kernel.org>
 <3a1969e7-2c4d-b64e-33b2-57311d73fb45@linux.alibaba.com>
 <20230321032921-mutt-send-email-mst@kernel.org>
 <b7e44ed9-ef85-bc89-b146-dc35f1af574e@linux.alibaba.com>
 <20230321115516-mutt-send-email-mst@kernel.org>
 <90da02fb-ab7f-6c53-fc46-aadc22564539@linux.alibaba.com>
 <20230322124010-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230322124010-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW5PR12MB5623:EE_
x-ms-office365-filtering-correlation-id: f469bf37-9c20-4a46-b1c5-08db2b4c942d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7+ZN7MbSHHN6V9J/JNGzs/12tNMNY+Amv2txFJu5eHReCeVZ0jJcchTywD23kbcueZeJ8YuCeIQ0/N1IseIRIMy0ARjsxeOKML1JgOo/+2XLi+xEQDzq69veEehcL+Gv5EjNu0zcUpqfJQHH6wDerBBGvw1HLD8nIRh9Be3xEFwIl278cpwuycrNY55gfIvH2fe5EAAU69K8VvZPPlACiaJwFE/o8go4sf4ARt01ic3jQpa+TbTtTzAruR2yXfLMXzTapbXUJ67hHzDVY9fJM9ij2sT6LZNtAengxMGhxSyc3TuwXw/MbnLOD78tmrq6X3T+Y+ec4IE3nbmCC0jWMg1PJ53s8XzuI2WVrollIS7moZ3aT1HiGQJOwLiF2iSjpTJrulgZV+VR49EtR9QzgUBbMBP24blQv1IvznSIzmENsy5IgslpEE2sfMZyHc+mmZxkB+U43FTnuwLhVj0KGSQH4NlJdaUtHdEPL40arNjlKY6YxeIGZfkWQDWxn9eEjq4/4eq+JFO5cPW4/jVLVYyiGWIvYGMKsNqGlYAxn4ymBuDldx6ERBwsXiwQzpcp0fwa2hMZjAQB00M0nRBHG6HXZQxS+RAHGhP2nQKRKm4DHXB/NZiBxFWxQeqTicI24H/uWSkCsdcmB7CzrD+SoLl3rk3rzLRhahAgbkpWTE2kYMevV3N6VcVk7YsLbsCpWLeSr38C+RyoAOROsWAX2Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199018)(4326008)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(316002)(110136005)(54906003)(4744005)(5660300002)(122000001)(41300700001)(8936002)(52536014)(26005)(6506007)(186003)(9686003)(478600001)(71200400001)(7696005)(86362001)(33656002)(55016003)(38070700005)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEpBN1d4NW5FTDY0K01veGhJOUpPTm92ckdORkxGSVZtdVVKYXkxM0dzeU5N?=
 =?utf-8?B?K2xSU0lmcUxmTTBua24xd24rY2s1cW9OQTFoMGJVSE1uZWQ4Vlg2ZnVKRnJx?=
 =?utf-8?B?dkV4UUo4QzJqMU5nZDZDL1JGNmsxZlBoQXZHV1FtZzFzTmVsdUJ6TldiYytP?=
 =?utf-8?B?M0EybWlXYnNLSU5TcDRuZ0tVRFVCR0RCNnJhTHhYSWVQMWh2V3NSaUNSak5V?=
 =?utf-8?B?NkhBWDFXUDZwVU9OajUyc3kxd1NsbFhiVXRENEJjMnl2clZqWFhPWWZPSU15?=
 =?utf-8?B?Qk12VUdWOVVwemtpTEN0b1l1WGRSTjl0bkNhUU9RQUR3UVJ6RzlFaFd3S2Zu?=
 =?utf-8?B?WW1lcGlibVgrRzNSNVN3bk1obis3ZFU1VUJrRW1BcVk1OTNOeW5lMW9PTk92?=
 =?utf-8?B?cUM3VnhYWFBGcTVyT1pOZ0pHK0I2cEFhUkk2RTF0dkhXeThjUW9vemxMczVh?=
 =?utf-8?B?ZzlxVGhxUTRleHQrOVVTRDNiK2NjdHczOEZaYnZBTEU3VnYvVGZBb0NuWTFU?=
 =?utf-8?B?bVR0aFFyK1kycG9aaENOdGtDR1h5RE1FL3pqOElzWE9RSHlKWXQzTXNtZHo5?=
 =?utf-8?B?Y2xCOFNrQnkvZ2RwdExLNnl2STlRSE5CT1hibCtYWTd5LzU2VTg5ZGF6R2FP?=
 =?utf-8?B?aW5USjd4MUJsYk02V0EzSkpyaVBac0xvcHdsU0tBUTRSK3NpLzNBR3pqZ2lV?=
 =?utf-8?B?Zk9CSkhYUWJqVU4wdjhvdXBFOWlnMWZTN1R2S05XSWNiZFVxTWxOanJEVnVp?=
 =?utf-8?B?bG5TZVVwY1NSQnpMWUpXYkNtSlFhNW5URFN5Z2cvbkdzUTlOY0V6dnlvbmY3?=
 =?utf-8?B?TmJpNUdFUmJEUFl4QkZHSStaakJvbzhHLzFTUm5pZnR0QkhuQVgxUklHLzhM?=
 =?utf-8?B?NE80YXZqQzVheWh5TStLWHU0aGVnc1A2blFXU1lHbnRlUzNRS3c5MGJUbk9x?=
 =?utf-8?B?Q25FcUtBdkdHMkN2YWR1bEZCRVRiRnJITU9lSnNBQktNYkpMZ0R5clJ2NkJK?=
 =?utf-8?B?UkFTL2JYdnRJbHhFSSs1Y0VkOFpxTmMrZG55YmhPek9oajhXa1BLRitwTDNL?=
 =?utf-8?B?NUNhaDBKSmc3aWI1cENhU2VCeVpBYWVvN3pjTUxDd0RmdjFJMnhwdzZkSk1I?=
 =?utf-8?B?OVhmZDZpajg4MldSMG1uRXRvODZLY2tKcHJBNkRIQkpzbEpBb2ZzNE84b2hj?=
 =?utf-8?B?cFE3Nkw0QWZnRFRDbDdZSWI2aGZ3c3gwanpWWUpycXp4UHNRQjBqWjNEbnd5?=
 =?utf-8?B?M1NxZmVDSEJpaVhJOUxlTC85bVpKTzN1OUNWb00rVVdUOHhFZEgybzY4cXFK?=
 =?utf-8?B?aUFJbEZzRTlEQ25QNCtGNUNsTDQya1g0YVhGRVhOOGV4NWQ5QWZIRzRUWGVN?=
 =?utf-8?B?b2lrQU9DK2hmYURNSWgzVzZKK0VDTkMxSVI2T3VHTmVLVzUxMk1uL0txaFBG?=
 =?utf-8?B?RjBDK1owYm9JaEYxZ3dsQ2pTQkl1cGNEZU1IL0dEZVVMUDdoNlRqRldWTzNi?=
 =?utf-8?B?ME03U1RsNHRSbGcveXZiL3BnWEcvb1BIbnplYWtiMGU5L1dkOG01TElLV3dD?=
 =?utf-8?B?dk1kVm5EQjBwNERiRWZrLzhxTnNNWCtkcjQvS2RTNXIxV2tnUGVqeWFFMktF?=
 =?utf-8?B?RjdRbmMvS3ltcGRwdlBHbEY0QU9sZGROU3pYdlBPYXkxc2ZnMHUzY1J0YkM0?=
 =?utf-8?B?Ykk2ZWhBYkdTYk0yYk4yaGxSak0yQUtqelQzTGJEZU5GbEV4YXQ1c1U2MGdu?=
 =?utf-8?B?WDZXNjI0L0JwMXN4RTBkRE4wc2xHTi9EM2g4QmUybzBxbnF4eHVwZmIwMnJK?=
 =?utf-8?B?RDJTc2JiOFhhTTYwbFlXaTlxWGdGbFgzVlgvOGRSa2ZneEd2b3V3dmtSS0JJ?=
 =?utf-8?B?dlZseDE2a1piNUlzWDQyWVdUVE12UU45T3hBMU4wL05WVzZOeHNKWDFVd0VX?=
 =?utf-8?B?SzgyKzdObVN4VWlnei9iNUZyV2dQaTQ2R2xxUGdBQXFad3JDL3VmbHo3bVdS?=
 =?utf-8?B?S2xtWHZlMVZOSW9yMy9kRHFzZ3hLdGRUVHBzODQ1WCsxV08yK3FJQ2oxQzdz?=
 =?utf-8?B?dm16c3hPeEp1RHV1QzFHbG9rd0RsSFBvWSt6Skc5dFJIam4wNjNBODlFZGJq?=
 =?utf-8?Q?+LuA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f469bf37-9c20-4a46-b1c5-08db2b4c942d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 03:13:30.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlBj4WixQZVTuTAJHNsl2kQIsOwpDOKOhFbjGcBZrZ7dgZVsVjrxm673mUqgiPsXDpzLt73YQj2C5oIaSHOmVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
Subject: RE: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgTWFyY2ggMjIsIDIwMjMgMTI6NDIgUE0NCiANCj4gWWVzLiBCdXQgbXkgcG9pbnQg
aXMgdGhpcy4gU29tZSBmbG93cyBjYW4gYmUgSVB2NCBvdGhlcnMgSVB2Ni4NCj4gRG8geW91IHNl
ZSBhIHdheSB0byBoYXZlIGEga2V5IHRoYXQgd2lsbCByZXN1bHQgaW4gYSBzeW1tZXRyaWNhbCBo
YXNoIGZvciBib3RoDQo+IElQdjQgYW5kIElQdjY/IENhbiB5b3UgZ2l2ZSBhbiBleGFtcGxlIHBs
ZWFzZT8NCj4NCkhlbmcsDQoNCklzIHRoYXQgdGhlIHJlcXVpcmVtZW50IHRvIGhhdmUgdHdvIGNv
bXBsZXRlbHkgZGlmZmVyZW50IGZsb3dzIChpcHYsIGlwdjYpIHRvIHN0ZWVyIHRvIGEgc2luZ2xl
IFJRPw0KVGhlIHJlcXVpcmVtZW50LCB3aGF0IEkgdW5kZXJzdG9vZCwgaXMgYmV0d2VlbiB0d28g
ZGlyZWN0aW9ucyBmb3IgYSBmbG93IHRvIHJlc3VsdCBpbiBhIHNpbmdsZSBoYXNoIHZhbHVlLg0K

