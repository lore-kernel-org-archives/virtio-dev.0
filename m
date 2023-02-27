Return-Path: <virtio-dev-return-11317-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF0C64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 16:27:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D6A112A884
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 16:27:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE6559865FA
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 16:27:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3BF998644F; Mon, 27 Feb 2023 16:27:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0FB6986478;
	Mon, 27 Feb 2023 16:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6GYTYYNcdYphT4xcrzKncopl92KhyUiuiz5kS/88Y0v/NbnGuuLd/3iOB7PVONuAOQzn3T6wtSXk5grfaIAk0cInGXzKsws/C8vEGBl1ZdfHvrJvbjNhrQJq/FNvU4zL+Ihtu7Xn3zPfe8skurlBCisk4Mr6YJaESyphOuDeKTtP9dsfdJDPydALpddJNsuzrwxnTObcBlCsSfKN9AP9VO8oMM8liQzzqBiOqSe8261+6YZsuxG/lcJIga/eli17XkWFH1cTrsdxAYwEWgjVQAaQxC16/8jUTmqY/CI46FwGNEHlkxTd/tLZ7QT7+ionW1I5I0I2do6zstlN8Oz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQV0DlGAyUmVCJWz0VRIYIQRv7g+fodbw37ktXw68Xg=;
 b=TSATwyHlBAtdJNYC8m+K2vlYysbV6g1XHjPlbPdNnafFr1kuHRSyN0VDWjVuWQzc63cGFpYX/NYUeaoGEZAlXqLfziM7Jj9jh/q85tLmZ+DRnFStxGedM6mXJgb7wrk/c+Y0yVIBL9rAxMs6XWWvRr0TSf7VvW4RDSnlrGOQUdOhKg+oTLqa1rSAU7hOoC3bZrF1gixTLaHAtRfXoac8neVK/T6piMtTebSsUeFunb7ANHX5iZ8ru0NBcAy9zFexJCZBEReE57xF/HRA2sPqOCkYKdV4M8kLtr3gQ+tYzAZsmJwtgHTchFnpfF2rPeXY/EKHe2c2iKYPm46BO+1UqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	David Edmondson <david.edmondson@oracle.com>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v9] virtio-net:
 support the virtqueue coalescing moderation
Thread-Index: AQHZScXyLv/WnfWq8UO7YKmjB55KUK7hnuqAgAElBwCAADi7gIAAAE2w
Date: Mon, 27 Feb 2023 16:27:02 +0000
Message-ID: <PH0PR12MB548133DE2C9D3B29B99DFBD4DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
 <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
 <2b67b976-210a-b8e9-cff2-259bfcc46591@linux.alibaba.com>
In-Reply-To: <2b67b976-210a-b8e9-cff2-259bfcc46591@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5762:EE_
x-ms-office365-filtering-correlation-id: 5fab7b97-5f69-482d-bb92-08db18df756b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o6TXuQxcx3bdft9OLUZxlSl6z8cEC0na+fXbhuJry92APKxn60W4kJzVMqs7AYzCRtvuvWtkuz01WMwZuDRdMepLO7UBz6CUFf5qtXWGpSQzg+3dNOgMmLAe8I20IYLFYuP48CnMUW9TJsLXDj0b3hiQ9la1WzX+sgbX3qNetvNyEC6dOS3GWtRwpjKrLLmwBklJOnFUvqvH3Y6/TKmVkjDZ8TEhOl0Z1I172oM0GmSOKixEgrK229n1ZFsSr6y+Wf+go5+nm4nSxLPI1Mbci8v8SLME6/Ml4sUWhJkiUqtiS+d3I9slzijx0skXT/Q0vDUmuVYAZECeVw0POqfIGSqGUqpFaE+eh5QqyE743o/ehzPZSzjVDi+xLveLY+DmD34lMNMuO6WZy4pOmiYeKE5qGw2ofrU49ZgcnbQTvuS7Yl2cQcIWcthPTSd/rn7M9en18QxqjPjmFNHPnDKhFVP520aUO2IWZR2aSWElwzSlOBS80u/Pwti+RKMwqvQTeAMj4/6LOrYou5LCGEf7j3Rgeu9+62ByCzcOKj6qOEnVdDF+5PZwHl/gOh4ONo06azp58xn4WQhM+CylIBmKMS6HLfSIdXm9kYJZYOqvWN179JFRxTwE8w32MzaFN7vT5npn2Pi1Et98qcM6JT3w7gGaFvmm3ceFmaCFKDv1FGu499Ns76xyHWS2c1cM3n0w5YBCyBt1ZRKHbABH5Gp/3w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(38070700005)(186003)(7696005)(478600001)(71200400001)(6506007)(9686003)(33656002)(55016003)(38100700002)(122000001)(110136005)(54906003)(316002)(41300700001)(4326008)(66476007)(66946007)(2906002)(64756008)(66556008)(66446008)(76116006)(8676002)(4744005)(86362001)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXNjT1BWVzN4eWFIYk5ydlczSU5ZWGMxU281TmJSOUZUMkhlTElTUFJ3OVN4?=
 =?utf-8?B?My90bFFxTkFtTFFMclEycXZndi9wUUJQQStWUjlhUGR6UlBncHJ4aWliYjVv?=
 =?utf-8?B?UCtyTHVDSVVyTzdweFlIWFg3TlF0cFUwR3Z3c1lMdDdIOGozNjFoaGdEc1NU?=
 =?utf-8?B?MC95QzB6aDU5RG9FWTNMRWp0QWI2NHRjZ0lmeUNZazFaWVpvemUrdGxCRE8x?=
 =?utf-8?B?VHZhTzFqS2wrQ2s1Wnl5b3hzT0cwYUlIWHVRc2YvbUl3dGFjb2paL3dYM1Jn?=
 =?utf-8?B?VlpLUVRxUEVnT3M2Z3Iwc2VLc2poaVUvTlV6MitFajJqMElhOFdub2Zwak9t?=
 =?utf-8?B?eDN1ajB4eW9ZSGdFcTRCZ25ibXk5N2t1T2J3elhlWTNWUTV6Z2wrbXJ0UHFP?=
 =?utf-8?B?Q01zaTNWS2FCNFMzdis0UkxUUmtvbU8zcXVTUWQ1R1cvU0lRbW1hM1d5S1M3?=
 =?utf-8?B?NWxyUHVKTE9mUys5dVhzMFhoR1hLb05YVUNYbXpxeWhmcGxzeG1aZDk2SmIy?=
 =?utf-8?B?em8wZkZ6ZUw0bG0vSTJFNkhaWWpMQWFJOWFvblo5bGUyQ0FWTFZ2bUdadGVD?=
 =?utf-8?B?emZHTE5UNWl4dVBTSXUybHBmL0x0TGZsbEVEelV2QmNNK29JT1gyS0dIREVO?=
 =?utf-8?B?Rlh0Z1NDbmoyUWZHRGJVZ2k0MFA0WkU4ZVhwaExkY3VuMXBOVmV4WUpQeThP?=
 =?utf-8?B?U3dNUGQ5UGFCMUUzNUNCWXVMTGJLZDZENnlROHQrMzg1UHhJNUVnTS92Wmxr?=
 =?utf-8?B?Tk1wQ2ErakEvbGtwY0hXb1VnUHp5a0NUN0RCUFRQL1NzL21oUUFlVjFTUmFH?=
 =?utf-8?B?SFJUbWRWTG5IMmF3WkdkenFMMm1KamlzOFZHZVVVRHBTaVE3V0hpU0wvb2ow?=
 =?utf-8?B?dUl6ZFRuTC9TZTlGaVc4TURDa01SWjlxMmZpMGV0Z1Mrakl3Ym9JamV5WmRp?=
 =?utf-8?B?L0ZTbUZFY0ljNFFXMFZBanJIbnN6OERJRysxTTByUGNpMFg5RmEySEs2MVNp?=
 =?utf-8?B?KzJ0Z2FPaGFYTU9YMXkzZkdHMVNKNlhJdnJaUXpyN3Y3UThMazREZlY1aFp5?=
 =?utf-8?B?Rks3aC9YSjFyRWRNV1kreGJXdkRlZ0xxQmcvSHRhYXRDYjZpQmx4ajJFd3NB?=
 =?utf-8?B?Y3BuaCthYnM0VCtoeVczMU9jaG5zQk9TanJFQjViS0pXSmVjeDh0dUNKbFJS?=
 =?utf-8?B?cmtpZHpDaVh5Ym1Ja0xiVDNiOGw0WWJSaXMxY0lKZmxMZnU3QXo2N0piaGla?=
 =?utf-8?B?VjUrTGEzR3dqeVFDRzROMTZVZmFHMTk2T3plSVVIeXhhSHpwRGhDWEJjdlRG?=
 =?utf-8?B?SDAwUldUalRQcHZrUWh5TXZxc1ZvaVhzL3VjazUrSlVjVW90VGhDZjRVbDM4?=
 =?utf-8?B?dnkwcFZpdjl0ZE9KNjltNGVMbnl2NzRRTHJRb0hoaUQ5MmFZVE8zWEtQSTUw?=
 =?utf-8?B?eGFOclkycHBWaGlYaUVwVEtFeDZ5MktPMGlYWDQzMEZwYm1vZEZjZUpQc2RC?=
 =?utf-8?B?T3VCdjZlMnpHemlNeXR0N01Idi9OeUJiQ2w2TVVxcHlrQ2NOQ2duQklHOG0r?=
 =?utf-8?B?cExZTHpNNU1PU205REUrVS84bGFQb3JxekFsUytIeUZNdXQ3Q0ExdTZQMWlt?=
 =?utf-8?B?OFpnOHpub2RPYUtQa1F4SG41WjBwQXgrb2JEaFQ5UG9SRUp5TmhXZkxubE8y?=
 =?utf-8?B?bXlJV2p5eHl2djBSMUxiOWthNlZhUXZ6aDJyWS96WkZ2N1dNZDh2Wk90ZnFD?=
 =?utf-8?B?YkRaczZxd1U5U2pVa3VNdWxMZllRK0NKZU9zaS9tVm1oOXdjSHJ4KzBSa0Ny?=
 =?utf-8?B?bTNXbUVlbEJFbFdUSnFxdWlBeHJZYWpMZVZFNWlMUUdKSkxraHZQQVlTUkdB?=
 =?utf-8?B?YkR1VWNJbk5jU2N1eW1YWHhKQTBFc1dVS0s4UU50bTFVN3hjK2kvQXdhY0Vt?=
 =?utf-8?B?aGx3b3NBNVk1M2p6OHZLZmFYTTJJZFM0V25XamZ2QnNXYlYzc2JxMytiWE51?=
 =?utf-8?B?U2x0RnZHSjFRN1hVTjdUclJWeC8zeGd6OHRHN0NDTnpjZ0FqaFZSanVoUGxK?=
 =?utf-8?B?eER6L1QrbUU5Wk54SzlHcG0xL3R0dnU4UkJDVTIwd1N0WEw4ZnZYMWlpck9K?=
 =?utf-8?B?SWJQNFRKVW1VVEtyak96aVRLRlg3d3lRUnBSU2ozMVc4WFc3S3NpSThpMXZl?=
 =?utf-8?Q?vBtveAE4KxGmTElE/9xXIz0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fab7b97-5f69-482d-bb92-08db18df756b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 16:27:02.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWcjBuetmfOIpW0DbepxuTynxV1XevdEV05KfWf0jT3Ws/gn3B09+j1R7XACIHm94b9RiPi3w/64a/+m1ZBlnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v9] virtio-net:
 support the virtqueue coalescing moderation
Message-ID: <20230227162702.OQzVZqZyyaNbyRHF610_q_O19tovFMP6f23GapW5iS4@z>

DQoNCj4gRnJvbTogdmlydGlvLWNvbW1lbnRAbGlzdHMub2FzaXMtb3Blbi5vcmcgPHZpcnRpby1j
b21tZW50QGxpc3RzLm9hc2lzLQ0KPiBvcGVuLm9yZz4gT24gQmVoYWxmIE9mIEhlbmcgUWkNCg0K
DQo+ID4+PiDCoCBcc3Vic3Vic2VjdGlvbntMZWdhY3kgSW50ZXJmYWNlOiBGcmFtaW5nDQo+ID4+
PiBSZXF1aXJlbWVudHN9XGxhYmVse3NlYzpEZXZpY2UNCj4gPj4+IMKgIFR5cGVzIC8gTmV0d29y
ayBEZXZpY2UgLyBMZWdhY3kgSW50ZXJmYWNlOiBGcmFtaW5nIFJlcXVpcmVtZW50c30NCj4gPj4+
IC0tDQo+ID4+IExldCdzIHdhaXQgZm9yIG1vcmUgY29tbWVudHMgYmVmb3JlIHRoZSBuZXh0IHZl
cnNpb24sIEkgZ3Vlc3Mgc29tZQ0KPiA+PiBtYXkgbm90IGFncmVlIHdpdGggbXkgY29tbWVudHMu
DQo+IA0KPiBIaSwgTWljaGFlbCBhbmQgUGFyYXYsIHdoYXQgZG8geW91IHRoaW5rPw0KDQpJIHdp
bGwgcmV2aWV3IHRvZGF5Lg0K

