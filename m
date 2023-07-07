Return-Path: <virtio-dev-return-13317-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A4EEB64DA
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 14:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6652233099
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 14:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AA85986811
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 14:20:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2399B986808; Fri,  7 Jul 2023 14:20:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31D13986809;
	Fri,  7 Jul 2023 14:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIDe32pBr/WXz9aVtpJEgHfNQbbbQcIy7/N1dlKGeVer+IlSwj1PGA8+f6oBSJ0gA0t6gYyycJd6y/cUw4hHH7ie4lHVnJSIDrOtrzlywXsxRFRjpjJRnPconrWyPvA5wHCeV9wdr87mXD5iKmaGXBAhkDcr2cUOqzXgAo7c71KRzgT1ONoFwqq+PG4xE6PDJMVrvHnEwXlYQ+rvDrloePfIdkvDVm/uj30VLBI3G7+opZIrWxNNpI57iPw87q9PrRWIc63HrXIrR1WkMARhXBk5dKl5H7pMNurh5HS84y1T3lWxMjbc7tBkOZW+A2/ByiUtUK4+14JPcnwlx5lc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWns5WVOeBighpgxIwa9JUrp+xDXhgncNwr3YBn8w2A=;
 b=ZNEQS7rXmp31Q66Let0HrkMrFnmv+GhqRF1KXGl4xsptdiVpuDEwxNjscdPl9JksjFjXIR7aMuYHFExB+zhQ8S6+84zzP6oGtXb3C5AoUuovb4eG/wSkIqCX9srRdgFzG0s/5dbwOQvq2Yp6PAzeDOA/VbTvECGitTVS9gxHDEyW+3f9I1d29+xtgcI6Omyahj2cSPx/3AjGpgYakSzDlXcACsZzPp5ZLn8G8u8FmG6f1cpD1FY8eaTCAjZof/ZO10VPqyf8YmNvaMz/jIKd1bXI8s5L63K4kyevfJCLbngCBAeGABS5ppmF05Xo+s8Z0xVL4QAjvkk3qAMiF9vMzg==
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
Thread-Topic: [virtio-comment] Re: [PATCH v12 3/3] admin: Add group member
 legacy register access commands
Thread-Index: AQHZsIa8NKsObqKObke5yxkM3VEKNa+uCmeAgABBWRCAAA6fAIAAAFfA
Date: Fri, 7 Jul 2023 14:18:57 +0000
Message-ID:
 <PH0PR12MB5481AE9D64865B394BCE4084DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230707035401.107855-1-parav@nvidia.com>
 <20230707035401.107855-4-parav@nvidia.com>
 <20230707043229-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B9E319B41225FEAE3BE7DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230707101650-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230707101650-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6038:EE_
x-ms-office365-filtering-correlation-id: 7240bc52-3b26-4068-4618-08db7ef51a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8XJnlw/Zpt544J7Krh/hsedYK3Pa9e77yqMJq8q2KlST+kfd0CbTPngHztdGkbq2ZvwAQEKCMa5k8iZIKKh+QFgb18io1beukErsjEIIwKV5bgw/zaqbcDdQ8s9EYKSNLHAir0CEhPpkG6swjkmmeB7s3UxGMheGusHJiqJc+1CzH0QjZo232G8tZ7VrcwDWkPosB3s3IuvSCkLXeNv6Sfx4CfRfT7lHqlZ6ijMvinLRYIcq/mWnKc5+Doy0w6QEVZr1bhE4vCLxGXKPqdMAb+VUd3jRGbOpAI+TApG2c/ruzMzaoEFdSowG/UwE2zTCWUbS5XJwT0UCkN9t+F9vDGAwekO98YQQtqgoWVWI6yeV3/c+jOAW0hjKfYDePYxNPA0QohXpifHOoO5XtqUDUN7WAM779VWuR6cYQc5sZ47sjA8IetAvck79QoM7AnTMtXNKJzA8kUNbP1kCR3eXHfAff63XxL+QUANXCQvZW0HHE7dXODTCpHqAzdVZceBsO+ziRaWdIiUTrtXylLqkRAlyw2IquQvkjCjmeb5xNhkgvT51uvdqSV0KJkSwdZn+NYAlKXnr2dR+ze8AwFoPL93MBMOYdO1ZceZmgqLyrb7RhkYB/g7DEpx63qEG7vfe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(6506007)(26005)(9686003)(316002)(41300700001)(83380400001)(107886003)(186003)(7696005)(478600001)(54906003)(122000001)(71200400001)(55016003)(66946007)(76116006)(64756008)(38100700002)(66476007)(6916009)(66446008)(66556008)(4326008)(52536014)(8676002)(86362001)(33656002)(38070700005)(4744005)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHpmL0tacnVCOTU1aUQ1OEtuaWkvQkVhdVFDSFZxY3c0ZVpxQjkxa3VNQnVS?=
 =?utf-8?B?WDVqN05aTkgxUzl2WXhuS3dsZHI2bTlrNThBK01GODczdUdrQXZnZTFkV3RT?=
 =?utf-8?B?aDE0L1ZacnhQSnU1Q2FHQmpxRVF3eXF2UDhpNDZhNFkzK2hLeFJaNDRJQVAv?=
 =?utf-8?B?VG92aURCcDhYOUFqb25UU21JZHBodEFZc3oxMVFJL2FxRkszczEzVGtCaVVz?=
 =?utf-8?B?S1M1bjYzTExDNTg1cU42V0N2OEwvSWdTMGQza0ttTVhlTkhTMDUxbERBUHR3?=
 =?utf-8?B?cStWaVV4SDJKejJPSC9YSlVWOXVJN3VMekl4aVZDMTVsVzdEdjgyU09pdUFU?=
 =?utf-8?B?SnYyNWhSU2hOYW14OVAzUVMzVk5DYStVVFZHQXJ5NXVlZ1NSMGZ2TXlvNWYx?=
 =?utf-8?B?MCtnRGxZUVRKU25YNjdpa0NtSHdkNm9HUnMybUVsd1kwVVpjbFJCU2VwR3RQ?=
 =?utf-8?B?UG0xbkx2bWFvYkpXMXQyWEFOZ1MzcElPbExYcURLajAyNkNvUjRzcm9icXJI?=
 =?utf-8?B?ejIySzNjMlRRUGxKS3RaVGw5aWpIZTJQOUZCaWMzK0RNSDFGeExMYVlMVlhY?=
 =?utf-8?B?S1ZnQW9SaVdxeGZrNnNQNGhBZkh2YndOdElnSUI2TWVQN3doeTdVeHB4aHVJ?=
 =?utf-8?B?RHNUYmt3NXNQcFNtUWNtR0JMRlZKb3JobVQ2dGxncmp3dFFYTEFYenRQV3ZF?=
 =?utf-8?B?YlFxVEphNVdpMGRHaUEyS3hnSEZVTUowUDNqS29YV1ZLTVpPSGYvQVJya3Bt?=
 =?utf-8?B?YTh5UFJDN25PWG0xdlVSMWg4SlZBVEp1NWd0OVl4VStuSTU0QTFiSmZqQWZh?=
 =?utf-8?B?RXhXTm9CamN5Uk1QaHlVTVFENUUyMk5USDZ1SDVlM0V6OTNZTUdBVXJ3cWt0?=
 =?utf-8?B?L2dvYS9SNmJuYVhwNytXR1ZqNnJ4MVZqSnFOUUY3cWt2MjJtZmhUL3VsYnMw?=
 =?utf-8?B?eGlqdlZIalg4TmhEMU5FZkpUZzQyQ05tb1hSWjRLN3dyd2FJRmtWa055QWgx?=
 =?utf-8?B?bHJPSjljSUNhUytKR0hxamZLL2pXUDNrQ1FsR3poNXlYS003end2cFcrT2FT?=
 =?utf-8?B?d2V3Lzc0R0I3R3N4NXREcTkvTE40M3Q0c3AvT0JJQmV4bENlSTQvWnpNRHJp?=
 =?utf-8?B?OS90NklNNGZpb1RZRHNCbFNXUWJ6NUFKekl0OXVVVEFuNTBKMG0yM24vMUVO?=
 =?utf-8?B?SG1LVDA3dklOM0xISHJHR3daNjRPUldZZW0yTHM5RWUyRUZkSjljMFRFNm15?=
 =?utf-8?B?UFdnWW90NEM0K3hWWWgzTitxRElwZERleFpwc0tIdXZ0azNPVnJibnBjRjdQ?=
 =?utf-8?B?NkVYVTJxMUFzb3VNYTVNMGZxMVYwNDhKNkV6eGtJNnlJY29SZ2xjbjlWb0s0?=
 =?utf-8?B?cndDMkUzR0xIOXh4UXdaTi9WcVp3elVDSTdpc1FjN2puVjZEenhqbThGTTBk?=
 =?utf-8?B?bjY4QUxsdjkrbWtSVEhZUG9YazRJN2Q5YTU1ZFVMSWl1ZU91MG5OYm13Zmtl?=
 =?utf-8?B?OVgyVUc0RDF5MmFOd1duVmZwNUFhZnRlTTQwY3dTdWlIZnBpdllpWnFNUzJ3?=
 =?utf-8?B?TE1RNEpkcFNTcVJDQVU4ZC9SSHFuajdEZGZuS1ZwclR5ZGh0d0o3MDErZEdC?=
 =?utf-8?B?elVkbEhtZG5wV2ZtaDlHbWZiQlUxTDBLditDbzEzMjNSZFRUcGVFeTJLNGRF?=
 =?utf-8?B?cFlzWVBEbytFQTMxUnVqbk1oZzc2eExVMDRpN3NOc3NUQ2plRzJ4VzRKSUlk?=
 =?utf-8?B?R1I0MjlRNitGY3RiQ3Z3U0M0blJKN1BIUk5nRU5xdEF1UzRWSkd1Z1lNMk1H?=
 =?utf-8?B?QU1Kd245ZWYvcU82eEZ2OFlSS29xdExRZC9FOXFyYW9LclU5SlFnZkI3anNY?=
 =?utf-8?B?Vld3QkVFVVl0RWkyNUdIUDM2dGtWR3pmV1d1eThkUXhxRHpqNm13azgxc2Mz?=
 =?utf-8?B?VjBNNVg5RDExRGxPS2NJRkZwQjEzRDNObHBiRFFZd2hEaWdySXVpTnNvQ0Rt?=
 =?utf-8?B?cStJUXducFBLQXo0d1M2RTVHN3ZURDJoZEI1YTJhQlBJVjl0S2MrYWswTTlZ?=
 =?utf-8?B?aE81Q0lIVTdlZkdwaU1hM0dXcUFKNmJNU3VNRUx2QktjZjllZjU5MHczVm9Y?=
 =?utf-8?Q?rUo4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7240bc52-3b26-4068-4618-08db7ef51a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 14:18:57.1788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snWoQnrymsfcmA//gULeCSzYZ86ZrFUIVe/f2Zu1V/fyc4k3CkBydIdCVYumxbMjEtF5fJOtmUx7QM9dqpzO5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v12 3/3] admin: Add group member
 legacy register access commands

DQoNCj4gRnJvbTogdmlydGlvLWNvbW1lbnRAbGlzdHMub2FzaXMtb3Blbi5vcmcgPHZpcnRpby1j
b21tZW50QGxpc3RzLm9hc2lzLQ0KPiBvcGVuLm9yZz4gT24gQmVoYWxmIE9mIE1pY2hhZWwgUy4g
VHNpcmtpbg0KPiBTZW50OiBGcmlkYXksIEp1bHkgNywgMjAyMyAxMDoxNyBBTQ0KDQo+ID4gPiA+
ICtncm91cCBtZW1iZXIgZHJpdmVyIFNIT1VMRCB1c2UgdGhlIG5vdGlmaWNhdGlvbiBhZGRyZXNz
IHRvIHNlbmQgYQ0KPiA+ID4gPiArZHJpdmVyIG5vdGlmaWNhdGlvbiB0byB0aGUgZGV2aWNlLg0K
PiA+ID4NCj4gPiA+IE5vIGdyb3VwIG1lbWJlciBkcml2ZXIgaXMgbm90IGludm9sdmVkLg0KPiA+
IE9rLg0KPiA+DQo+ID4gPiBKdXN0IHNheSB0aGUgZHJpdmVyLiBBbmQgImRyaXZlciBub3RpZmlj
YXRpb25zIiAtIHlvdSB3YW50IHRoaXMgZm9yIGFsbCBvZiB0aGVtDQo+IG5vPw0KPiA+ID4NCj4g
PiBEaWRu4oCZdCB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4NCj4gPiBEbyB5b3UgbWVhbiAiYWxs
IGRldmljZXMiPw0KPiANCj4gYWxsIGRyaXZlciBub3RpZmljYXRpb25zLg0KT2ggb2suIHllcy4g
YWRkaW5nIGl0Lg0KVGhhbmtzLg0K

