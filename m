Return-Path: <virtio-dev-return-12579-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F196C77B7F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:25:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFD5BF90F6
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:25:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D69769866DF
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:25:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD93E9866C6; Fri,  5 May 2023 15:25:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9550D9866B4;
	Fri,  5 May 2023 15:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQkWhVyHBqfbFQlzTlqMRKl1e9XOFEZscNU2lzmvChCKBYnS5x1q3bysUfPau/DCNC629vuPxFxhcxF7w4E/gB044NnZKHVcd62p9XpkBxf78jkA8qfC0CbrP5K7MQk0erjh4x7BrYDAouPoefH4DdaXR4rAurwQvWaE9z0gU9k/nRYUbx6+iBJ2KL64bo3IjVC6zs5Xt+azEEpl/ErTGHf5GPqGgwpwfUNVgku1NqVK91dn3zQwWL+7qrmnjl9TQiamhprF0fOnj+Q39FGQY16lgYVCKKwKz0u5pKdHN4wHxAhHM2GfOJrSXG5REiuTFW51vDWMsoGgmkhRzG6aOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpYIfsNtzxTUTDBno1KENhMUC+RT/OLtNOfxOHcEc88=;
 b=oROjn/wWOEb16TjwvyzyhWNYeGlchJe3H2JU5E4ogy3vwgwebKUE4fGNqtumd0NtR8EzJOyHGZNJlvQV/zIBqK01Rv2V3weCXYbQmjSPH+FhV+lkPhvwul3Id8QKT5iS/uu7EoxJ22oopF6RyPWzjw261iaYjje61Bw/G970M5aTdhA6mi1wHgPRHwu0eU6eSRhwnoeQXI+cdd2cTzWa0blZqLdUvllugqOV8lMO2kvzYxU3FAzPXwipBsLxSghKWPqDvn7J+R2p6Z0CELWWtPXcmk9zTbM+XD0fBjWTcutcMJuPescSRzEEqAoGvSjI4tcfqQhahRZ9yHAryhsO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci
Thread-Index:
 AQHZdswSyG/pcJpYf0OyhtV/kRPNfq87BFIAgAACO4CAAxNugIAADL9ggA22XACAAABMMA==
Date: Fri, 5 May 2023 15:25:07 +0000
Message-ID:
 <PH0PR12MB548113619F52E61A5B782815DC729@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
 <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
 <a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com>
 <5cb79b37-a066-283c-eee7-afd26146d988@nvidia.com>
 <PH0PR12MB5481B60350D145531A43E567DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230505112108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230505112108-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4267:EE_
x-ms-office365-filtering-correlation-id: 1b589c01-4d0d-446d-9cde-08db4d7ce861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N1g9N8jwcpmRwR6ibwnbKyzok2Q644CEUkVsOI0qw9wtlZQYf82VEPYL1HkOvNSR79Pagk68BYqvAfvoA81Hc4GcY+ea8WKTfG3/RUT2k9rDCSKtNB2kE7qnw0SYWofzMZ1XmzUXoGRTXirybPOOXLPhjdukG+VG/6zUyetCo1SVmT+OdVmWm1DvSEljV9Jtk/xjgbGTrs0iK2uq0EIjqDA9R/9pWkYCIsJWrDFtkWgYg5hQX180gdVbQ6/JSrQ+3jEgsAyaeBG+dOCNeJmy1XhDO3k+aSeQhsNAUr46MLpVLBd7N9S58NFK82k7CWYojw6lZs7seGBsge7WFRAue6aZqpMF5Jbx0VttCrqvd6vI9JjY3dbHIVVhuHT4t5Vpj65vb6YesPeSX/v4UQfyYOsKhuTs4+UnHV2VCSbuJNuQPN/cE/lQ+UuKn0xwr3rm1fpOzWJREA6Wh5Ih276keX48XQhMCWUyIWvAaJHwQnVuofzU1vzY4Zy2FvLjbDyybA7NNabiyuad+LWeCiujPAiN8ISUm3rhsTdGH2wsmq++WIyRze8V60xxjYMhu8GwJxjN4/S5i/zj4e7nc2diYOtzXtHLF0M86F432ijjAG4uq8J0LgeZZ9gtalSCJreH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(83380400001)(7416002)(8936002)(54906003)(38100700002)(122000001)(41300700001)(9686003)(86362001)(26005)(6506007)(5660300002)(52536014)(186003)(8676002)(107886003)(478600001)(2906002)(4744005)(38070700005)(55016003)(66556008)(66446008)(316002)(71200400001)(66946007)(6916009)(66476007)(7696005)(4326008)(33656002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2xUdzZkVnkyTjFGN1M3dHdXMVVoZndLTjZEUlJwcnZVQnhpWGtwd24rcDZP?=
 =?utf-8?B?aU15UzdzeUZ0djBkQjdXSEkycjlUajJJaGpmbExEVHUrUnQ0ZlRwT1QxVDFQ?=
 =?utf-8?B?YXczSXZTRjhNNTdmZVc1aXhuQ3hkQ3lYVW9YcTFVZGFJdkNObFpnaXJ0VWln?=
 =?utf-8?B?c0p0RHlIVWRrWThLeldVUURVaUhxKzVmVFkyZTBvcDhJNmt5Nm5TTS8yVTRJ?=
 =?utf-8?B?UmwydTRkZ1VqZng0bWswZHI0VkErRFYwVDh6TjdzenNqYkE5R0MyNmhmL3Fh?=
 =?utf-8?B?RTl5WnRMZzNkSkhxYkdBd2cwTXhIRThKK2pscmVXcDFITHR0NmFFNk5nRW94?=
 =?utf-8?B?UDZZcDJyVU9mMTBSUUsyR1RzSW5YczVNSndLSXlIRUtkdjJPQnZjU1hLT0pi?=
 =?utf-8?B?WlJTelprNXBZQm1hVWZKdkdWWWMxVkFHZTVGd3huamV1cXVQWkxsREZ2cVB5?=
 =?utf-8?B?NC9mb3d1K3BBZks4RGo5dDVsV0xhQXBLcjZhV0FxaGJ2Y0JWczZGVFFaWmI4?=
 =?utf-8?B?eVZVZGpOTzdudVdlTUFPeUd4OVl2NzQrWkVEUDJ4dXZsUmhFcEh3QmNEZnpY?=
 =?utf-8?B?SFpqOFVqL3JWM2pnUzQ5bDgyM0lwZXNDNVorQmZWbjcrWG4vOGdDZ1BzMDlG?=
 =?utf-8?B?ejdJeTcwNitOOEFYVjZ6Ymh3NllRZXVuQ0hVN05BdVVNR2YzMVk5YmtxWm9Z?=
 =?utf-8?B?NlE4aSsreUlCS055QlBCbUlNdjh3dUdxNGxpTWlSV2s1amdvM3NMd2dCVERM?=
 =?utf-8?B?b3FCdDFlQjBDMm5zWUJMV3J6eVlYR1E4WkpGUTlkcUhnNWFWUU0zSkpKc0tq?=
 =?utf-8?B?WVl1dG5ObmxtU2JTOTJReG5mMW9GMW0vbWNubW5rTU1oMG5NOGFsanhtUEJC?=
 =?utf-8?B?L0RZelRxdGVWL0UxTDArekdPeU1pUlFFWUJDa2Z2cktiS0Y5WWZSZGEzWjVz?=
 =?utf-8?B?U0ZlNkd5S3BIWkhoUExucFFpWHBKZGtzOWVMcXZKMng4SThLamdTZnZ2ZnEy?=
 =?utf-8?B?OVBjMXFNaXdmd0huTWltYVRBaE9tVHNLQ2JwQnltT0x4RVlGOGNKMzM1b1dT?=
 =?utf-8?B?M0RDS0lUR3pxRDNxMW1qWmQrVmtZSXlRYTNjTStIejl4VVBzYW5SQm5xQVdX?=
 =?utf-8?B?Lys2c2RlZXVVM3J4NzVGS1J1Tzc5ZjRBZFJXbUpSMWlpTXo0b25JaUM2RUdp?=
 =?utf-8?B?NTFkdjBjWDVWT2ticG9DejJaM0pJNDdkYVhSR3VzdlRuakVwZUVNZml6RTRS?=
 =?utf-8?B?S0ozQzlsMjA2TFBnajB4U0gydFlheWhCUEFuRjUrOEI3SWFQdzZwUGcvVUhm?=
 =?utf-8?B?RzhJR3ZCTnRRMklrRkRXYzczTnZkK2gvZnJkOHNuaXp1UXVYS0Jic0pKczVU?=
 =?utf-8?B?aHFWd0ZlNUpkNGFxRDlhdWk3bTMyL3g1S2s3QmVKS0FaTHRQdGJmQ3J5WW1y?=
 =?utf-8?B?TDByNGw3L0lUSHZKODNZcCswRllsZDc5cGp0ak16TjBPWDJ4YjZQWFN4M0R2?=
 =?utf-8?B?dFM1bUUrWSs5emd6S21USWVIeDh5dVJjTkZMeWVnSXgzeHorQmQ1TFlBcmFn?=
 =?utf-8?B?YkhZcWFpOU9OQ1ZJYXdNYndNN254QUxxRFBkdXRRZDBzb3k4QkErelhxVVE3?=
 =?utf-8?B?eVdFdTJiaDR5UlZ3djlUS0VTUmFvdkNicHk1WS85Yit1YzNXVGhlMlFIalFp?=
 =?utf-8?B?ZG1pZUdIbWo4MjlrOVozOGFiYmpmVlBCNlNZOGJZNlpPZDh5TFowOTU4cldo?=
 =?utf-8?B?SVRXd0xrM1pyQnhqYm82RlFKTXRVK3dtL0p3K2FVNWdYbnVWNDNUbFlKWkF6?=
 =?utf-8?B?VjQ1Mmh6Vll4Y3MyM2g5WjkyWVhxWTdSS21FK1FWazNlTUNVeTFTVE0vU25C?=
 =?utf-8?B?ZlZUSEc0ZThUMEppckFMVzNBQVl4S2R0WVd5a2ZGUEpUbnVHeWgzQTFuMzg5?=
 =?utf-8?B?YUllcTh3Mzd6T1B0WmZzZEx1eUlhQ3hkMCtxS1JRdDRBczVHbTZkdXY2VDc3?=
 =?utf-8?B?Z1NoakNoT0xvOEU0L3BtV20zRWp2NDdXUjg3dnZGeVVRZ3MxS1BuRXFKTzI4?=
 =?utf-8?B?MkhxOWJBWHptRERRQlRvM1VGQzJ1dkUrYzZaRkI0TXFnUkN5YmJXc0pFbUVj?=
 =?utf-8?Q?cOPs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b589c01-4d0d-446d-9cde-08db4d7ce861
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 15:25:07.2567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFqTaZY7jSvDp67MCVXoI+5Lne6UN24Y8oCaXX24vZsq+F6VcX11eX+wNr/VX2w2khnNK0qCxtnVAphrL7Iv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Subject: [virtio-dev] RE: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgTWF5IDUsIDIwMjMgMTE6MjIgQU0NCg0KPiA+IFJlbmFtaW5nIGl0IHRvIG51bV9yZXFf
cXVldWVzIHJlZmxlY3QgaXRzIHByZWNpc2UgdXNhZ2UuDQo+ID4gSXQgYWxzbyBhdm9pZHMgY29u
ZnVzaW9uIHdpdGggUENJIHRyYW5zcG9ydCdzIGdlbmVyaWMgbnVtX3F1ZXVlcyBmaWVsZC4NCj4g
DQo+IFRoZXJlJ3Mgbm8gY29uZnVzaW9uIGFjdHVhbGx5IC0gYm90aCBmaWVsZHMgYXJlIGV4YWN0
bHkgdGhlIHNhbWUgYXJlIHRoZXkgbm90Pw0KPiBUaGUgb25lIGluIGJsayBqdXN0IHByZWRhdGVz
IHRoZSBvbmUgaW4gcGNpLg0KDQpCeSB0YWtpbmcgYWRtaW4gcXVldWVzIG91dCBvZiBudW1fcXVl
dWVzIHJhbmdlLCBib3RoIGFyZSBzYW1lLg0K

