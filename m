Return-Path: <virtio-dev-return-13243-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3131DC001DB
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 22:01:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7903529FD2
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 22:01:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6392A986823
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 22:01:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 52EE998672D; Wed,  5 Jul 2023 22:01:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3448798645C;
	Wed,  5 Jul 2023 22:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds+WLuiJLNYVCnhslPmYXP9U5TuIs5umrB//h/LoPwL/CGZWX3UCAcO0mTRJxGNYG74ywSPmsZi2e0vbSlzjQziCj25DqW9kEnkQkPCjCZvKir955/jXd2fzcGziKzqEZ4dNMorphAh09wUonAExFr3jzevyaX2uAJUDLH/XNPMgN/EqX08e3msTZhaNpOwCBGUl+wpsZrdM8LXB7uVx8KmglZNTY5uXjZlLdlkQp5A9T8iSpeW0OABHH8qXjxDBUQ2/YscqpH+HS3kOqF5nUgfyD2zP1Xtaa4NoATxDKAfzJPiBfPxf7ykNrlK1Z7R6pXQaKbcpDnl99OqP2/GsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsaok6MHoRV3+Ixu/1QAxEtBMZDNA9VBF2pVzNgSfYM=;
 b=KBOPd3J03EMcB/bsELqugx/rlEMhju+tneuJTVAk5NrCIqc15EF5Fo8smWabAY1NBHOn5DiRdaTa+4xmklzVmj+Mdr1uOeVmsiLkis7hxGMDQ6DcwpB6HrPpi4vFkJchgciYDKrfbmnOoTE70f8nCDKk6MbMzeJcTtNtJW3UwSsPsP/OkPh8Mi5ZgTtGsL2oaEY9wnLadJA6INe+YVwepFJndvngPX7gcn1GEZjRsDdIWYzhYGsK8skEBGfwGjZaxy6Q0d/jLYxZ4R09eUg/7uzLpNmmmxlmehjBSU+7JT893CgDssxsszuZNR5u0xQcPdzC5vZqUHajh3IupTkfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v9 3/4] admin: Add group member legacy
 register access commands
Thread-Index: AQHZrtCPgh0YjplyXkiMVqx0qNPzCK+rA1+AgAC3QeA=
Date: Wed, 5 Jul 2023 22:01:45 +0000
Message-ID:
 <PH0PR12MB548152AF43DE3C9851830D52DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-4-parav@nvidia.com>
 <20230705044626-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705044626-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7849:EE_
x-ms-office365-filtering-correlation-id: ecb04a29-49dc-471b-93c2-08db7da36cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 93y2/qRps39sHCtpM1XtAdqSq1lQUSXVTIx7NPRV85Ses6jpqJ1SQAVtTWOfwJbCTn04DzT3fd3YtreYtuK8lXa9FRbAnFHqwencePId5Cc2Wa/LqbkeAZ2JXR3o32/HXHGDKhddnF3UIZQIX4thvHoXKHKbnw0DMnTrZK+OD1jqGcbA0wkRVK2dYuHJ4sFGOKgGrBHqEgdJOetuf+5ik9OW2JeZEQM2vySD0i1hWla5BIXa7/df9ipvw+KPnpHkWaCCT8fzoRb5ZNfHIUfWFOl4POWF+1td9zLhJl+BBPBl9pa+UmvSQQA9eZTDspll0huzG1ARHqI4sKAd37UVzYyW2dni5Y6QtowSLrZrEdcV5+u2mhun0SuO43Q36hbXrGlkkV9jNBUrskbu8fT4H40AEZKQceID2rTlkU0ZD4vXluXZji6XzCPX6gI5gfV5ETraMqOInEBa6e40VaiwvW7mpAdcw8B8WzANhNKA7DLnDskpsCn80dPwmhXYlkyPjEZxZF6LXxtSkTetxMOxctxH0fpT8+g+Jnvg63lbDUN5A+Cl4IhNHStRSENWCl2BbgHNN00MxWCvbSRo3pSUjFJNlUb4ImEcLO9LfnSOf7m8IFiqqmYnGZfy04FF6DdZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(41300700001)(7696005)(8676002)(4326008)(316002)(5660300002)(33656002)(6506007)(76116006)(52536014)(71200400001)(107886003)(478600001)(186003)(26005)(54906003)(8936002)(64756008)(9686003)(66446008)(66556008)(6916009)(66476007)(66946007)(4744005)(2906002)(55016003)(86362001)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ampqcVNCSWdLd3o1U0N1UzhjY1NOQmVpaUFPOUJEUUhBYjBXcXhPdTNFOXFv?=
 =?utf-8?B?amJDSHRBeElRU0xWaXRaR0U4VjVlRHpJTlBWME5kdWxGV0JoSTZ6SFRCeFVn?=
 =?utf-8?B?ZU40K3ZWRERpbFQxbTRJNFZURkF0NFd5bDFwTU81UkNDQXV0dmYvZFA3MFBT?=
 =?utf-8?B?SlpENldUMWxVUE02U3V0cXVMcDhGUHZGL2ZvWUlkRzJLTlRrbTZTa2xYcXYy?=
 =?utf-8?B?RzlRL0src0EzNkowNDdQWWNKMVBkQXplVkVnQTVhbENqT0hHSkZlVkVoTzRj?=
 =?utf-8?B?QVl2V2lTSEU2cTNHU1NvZU10SzQzTGh3SmZ6ZW5tNzVMb3JheFhHYVhka094?=
 =?utf-8?B?WjlBak9oamNudlFvU0dRZjhPc2h0cnljWHMwcHVjdWg3MnhTZnZnRzBPaHNq?=
 =?utf-8?B?SEhLSXowWkhFaFk4K0loM0RGNkJIRFdjaHFwVHRCcTNZU1F5cmQ2UmsrZmN4?=
 =?utf-8?B?UU1EVHA0dG5CckJkOFY0bEFDbVJNK1JSS2srd1dEaG9zVE5UMU9sL0lmN211?=
 =?utf-8?B?d3liZ0U1cXYxbVpnZm9FMDFVc2hwL1ZDL0hTZUIyWUNIR1FWazhyRUR0eGZq?=
 =?utf-8?B?SkZpTE9wYU9lWU0wWlhyb29LUjRPUmt1OFN4MTkvTi8rTW9MRTdSc1lpUjQr?=
 =?utf-8?B?STNONDRzLzV3ZG9NMVRXNEE4SVRNSWd1cHhwa3NtYzE5VFd6RTZaRXQzSnYw?=
 =?utf-8?B?c0dmdDBORTR2blVyQjZKaUJPcmpWVm1tM2pBL2d1UEZzbGZUNnUvc2lZWWJZ?=
 =?utf-8?B?T0xwZmNsNW9sUkJYTjF5b0gzWGU3RExpb0tncVh4ODR0MGwrS1kzcEJ0blB1?=
 =?utf-8?B?MENWTzI1VHduWndLZzRsRHZoMU9EbExDekNVR0pUbDVyWW5vYzlPYnR3RlZF?=
 =?utf-8?B?NWoxOVpLN0RaQzczUVpOZ3ZUcVBNN01wNWdROUwzRUdiekg5aGdyNzB1VzRQ?=
 =?utf-8?B?Y1BHODE5aFU4SEo5aUh3QVM2Qm1wcFcydXVhSDR5R3YvZStuKzBROWgyb2ov?=
 =?utf-8?B?ckFNeGlqQzJSUjYxb01BcVo3WlIwQjFheTBFSUd1dkJPN2Q0V0hOcTg5dVBj?=
 =?utf-8?B?eEEvcE5YQURwQVpoOXV4c0FWcjY3SHF4eGVXSjdtbTIrNDgyTU9NWFFVTnpj?=
 =?utf-8?B?OVlqWkc2VDExQmRra2RNaGU0aGtsR2tpb1d6WHMvK0VsR0RqclRVZHErQkVZ?=
 =?utf-8?B?L3I3TFFMVUt1WmZlN0gvQXhBdlRIQ2xDQ1hmY2tuc01NVnk0Rm9rNG12WG82?=
 =?utf-8?B?aGF6WjVKdE1SUnB5dXpLeHdPMEYrNFo5Uko3L3YvZmNoYU4yT0pzYkMwams3?=
 =?utf-8?B?Q3A4eEpKbjZWb051dkdYMWpwMVdxdFR5WVpyc0dlS0Q4eUFzR2EwM2E0TTY5?=
 =?utf-8?B?bHRldVlYbzZlcjdmSFVLZWJBbk5teVlWQ2dEajFPZi9yNlJ0TG1ucGszeDEw?=
 =?utf-8?B?d0YwS0VJVVR6TVdHTGpvbUpTNmdmRFZXUDBaVFYrbUZmUGV1TXJoRkE5WXhu?=
 =?utf-8?B?bWZTMzZISEtkUHYzblNNMTNncURic2dSTURPWHhCN01jWHhnaHB4K2FqYzRR?=
 =?utf-8?B?YmFvQWNsbGFISEJ0b0Z2YzJZWEhKRW1HUktDUkEvR3dhaDgwR3lFamQxZXdU?=
 =?utf-8?B?aUVuTG5TbU9rb0RidFRzSWZscjJqdkJobWtjTThiSGlWQk44LzRnajBzVHNz?=
 =?utf-8?B?bHdjakVXWjV4TUdQU1JFUTlMNkJzWmZxUTVnVmZldWhxbWIzeTJKVWxJNE93?=
 =?utf-8?B?NUo3a0l0ek5DTzNzYzFNSGNxbS8zVXV3Mi9tRzMvMjVJQkxRa3lIc0FEcTFU?=
 =?utf-8?B?M2NQSVdzNXRQQ2QxeXU3b0krbzJ2bHVkTnhEOGU3OGQ3UmthV1YxU3dFN29v?=
 =?utf-8?B?VHZUMUFSMFV6bzlBYWFZSW9Dck1XbUNhVDVPUll1VEFIcytlZk1kQ1gyaVJy?=
 =?utf-8?B?T25xcno1VjlNNnlLbkJKMlNSYkFDSkVjNWdQV2pkeURWN0huekY0MFYwR3pm?=
 =?utf-8?B?ZXlIZm5PZDJBWnRlOWJPZ0tFdWcxcFArcUlRWFJmNkVLWWxNWGQ1ZFdTY2FT?=
 =?utf-8?B?ZCs3YmNIZWhpd3NSMzRWdVVuSlZaWmZXNGF4bkdHUHAvSlhKN29kWjMyZm9p?=
 =?utf-8?Q?Fcww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb04a29-49dc-471b-93c2-08db7da36cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 22:01:46.0675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWYXglAtZjfSKIjWIyX87KmnCEsy3UX9w04NXi/qS6f1e/riGONKpkjQKa2EvW01SuQiPrJlvVrrKxTBp6uZ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v9 3/4] admin: Add group member legacy
 register access commands

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBKdWx5IDUsIDIwMjMgNzowNSBBTQ0KDQpbLi5dDQo+ID4gK1JlZmVyIHRvIHRo
ZSBzcGVjaWZpYyB0cmFuc3BvcnQgc2VjdGlvbiBmb3IgdGhlIGRlZmluaXRpb24gb2YgdGhlDQo+
ID4gK1xmaWVsZHtyZWdpb25fZGF0YX0uDQo+IA0KPiBUcmFuc3BvcnQgc2VjdGlvbnMgYXJlIGh1
Z2UuIExpbmtzIHBsZWFzZSBkbyBub3QgbWFrZSB0aGUgcmVhZGVyIGd1ZXNzLg0KWWVzLCBpdCBp
cyB0YWtlbiBjYXJlIGluIDR0aCBwYXRjaCB3aGVuIHRoZSB0cmFuc3BvcnQgZGVmaW5pdGlvbiBp
cyBhZGRlZC4NClRoZSBsaW5rIGlzIGFkZGVkIGhlcmUuDQo=

