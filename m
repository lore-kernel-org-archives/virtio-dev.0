Return-Path: <virtio-dev-return-12626-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C7BC7EE22
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:35:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 307503F542
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id C4A9B2A8CF; Wed, 10 May 2023 14:35:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1963A986590;
	Wed, 10 May 2023 14:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg5gOH+pbb3zK12lQgUITrdolXu3pHQ0Up9H/dAfdtl7ZwrwFc49fe8G7SLYvamuWQP+lI/9EXyDZa4W49UWOQ1LJXFdpZbWcDJ1HYfy2Lu08IQdvjJ9W6v7KkImX+pbXkL9bonEQwmR6a7UuSZWTjEVbET3459Zwy7CvfBClgO69/K/5peCFlH3RmfnplzQyHdeUi9N+U8UhsOniPeeQfB0yTqGbLT144/0oyGVp024SWQgT84KlEdy+wiO4wlYCJNYlqj8AMlstHG+Cpbard6Bkv7GTC7UFmHVAOK2pRUVVa0ChqVeCaW8Q6x7fdSVpt4F4DSl5iC8dGBtjDP9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNsD3Epq6J2126Ygc3sqTWd/GPsth6pXjGLkOgBuV1o=;
 b=NlfYpiXpu54tIfj1hXEaNhOA54rxPCnm+xuuPHOY7unDDshcjZscPd+E3y7epCQWqHdLMWKzAAlvC/A3Z5pEMVbbwzSOaPRSpo4GHwSz0FwYWVXcmnMyapz/R6b0c2DL68+20+sUAx0FT62RqY3jxwQDacGDRL2r/+jqZy+B+YjVod6UOvUIwTQLLbftb58+dEbV+Y6UQ92LeVkDko+VMIafvqj67dIKrD/I7GM/WH3NWWCUvbWDw4UQ7QR67dymB+9v1B9d7BmWIdPKYAq8xa9KoOiiNE2FwlDCWenGRtuSm53ubZel8mofqJ2BCLNgkGWuo7u9ew06Xm5C5jBytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v13 00/10] Introduce device group and device management
Thread-Index: AQHZf2f0ARAnA61+Q02oyw5WsGCs169TmRIAgAAApZA=
Date: Wed, 10 May 2023 14:33:52 +0000
Message-ID:
 <PH0PR12MB54814BF87CB79304EAAADC79DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1683301091.git.mst@redhat.com>
 <ZFuqesg6YUSJi4dd@nanopsycho>
In-Reply-To: <ZFuqesg6YUSJi4dd@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5713:EE_
x-ms-office365-filtering-correlation-id: f46b1709-dd3d-4f67-7e50-08db516393b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4BV+sTn8urvmG9zkjFbxjUpYO7yhtcI6LzxnMxQWqf874vJfKg8P2hQCigCNBmlexCK8Iom8x1issBe8TeZ7q4wd/XFrAZRiaXYs9EhPvofsIozSqJVFPW4vvErarDs+JoIz732e9gof152/ARRYmMk/ndEtIVRex4owWQxQKPlwJ6X3RlzH7O29JyIQ5UrnW4z1vs9gpanyYxoqb49483Yb8SaNwOV7UpmRjUhxKowIvskN+KawWiLYa/GjraX5obxL5Z3lf3OG9R4J7h2Cxy2NwSQQNFDS4vAzIlx5fl4K/g8AAdEiVFhKfxYkIcX2/+OM98YMsJqD3/f5UkMc8o3d1MBQnUJ6rX5G4X6q36c0Z4DvqoEODmZ7QMfb38Jv3cSjE78A8j/2pNalY46u2TxlVdQU0qTN/wJC61HhEZnwCgWYMe0xjFnNFVpnFrFL7X8Sx6NzcOvO1WMXeVo0IEHnck5m88uRpTFxJe/k9kCujHsyTntZ8An1o2JncsXM06OcvdxeUJYGAIyBdTIagr07NnhyQaDG4GBCzR3aGU1f4pEUc71n2Esbpo97+9dzLnIt/NGWGgVjMAwrUJw3w9LHA76I1msof/TT2xlKLtR188S450gtgOQy5RXrq0uG9rQfMq9nG0Fn4iL0No1+Rw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(55016003)(186003)(38070700005)(38100700002)(86362001)(33656002)(122000001)(2906002)(7696005)(8936002)(966005)(8676002)(316002)(4744005)(71200400001)(41300700001)(7416002)(54906003)(5660300002)(52536014)(110136005)(4326008)(66946007)(66556008)(478600001)(66476007)(66446008)(76116006)(64756008)(107886003)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gl2Ouiv/P0tP61es0U+Qw9/zV9OrPL2Pt+t0uGnAw1EZ3rXfWHlaDqaQGnva?=
 =?us-ascii?Q?s+deC2byEoqyj97WM0PI5HWyM628/pFJm8w+J0WGKeUi/b1RC+qlZ3NF8lOk?=
 =?us-ascii?Q?+lBj2YeQPYuifBxHPHXbU5mCMCK+aWLgrZT9MSqB7U0vMNTSXyFXiY1rZ/7g?=
 =?us-ascii?Q?cSGt5ZNFvjbnDBmAjAagT6T68y843rp02HENik6GgsRfPCyfvg0W+k9UBzR6?=
 =?us-ascii?Q?bWCMJIWkECD8moZwG8uQdiEpo733JKEannFQs3HWSUrmOOc/BexcKrX5Vg9s?=
 =?us-ascii?Q?74wklZtVcZrtIDnsFkWWJx4b8Qgak+2e8+td3/ilo/Vbi3wM65xVNeYtqsIh?=
 =?us-ascii?Q?8Lzc5Ew4ZEjlEsWlgvL2lf/nrpGVjsBwQ24ATKlg0QJk0zMNUndT1HLf9DPm?=
 =?us-ascii?Q?6TDP7QwTBSL3QPjBb0fzfQN/PwAwsmGiFlYyMzDdwXMAqL2QUa2bshC+Srcs?=
 =?us-ascii?Q?GwmDgpSD1fxPmp32Zv04ToCx6sScdxDhmjvnQCESs8u+bxU8KNLShWJdRbkO?=
 =?us-ascii?Q?4AVUYWkI56eDABkeBsD5T8VLcAvdhZHxw7oBgDrvz9Qn/Va2vZoQOI+1DbBv?=
 =?us-ascii?Q?KkDs9FrcmLuXTCgMhPX/tHYsBrEJgNVkeGXYvCBFPMrp3ftHLMND0oatkEg6?=
 =?us-ascii?Q?h+XOaTZGe0pDxxJ0enQaiAydwxps4Vuln1IYL80Na4deKEf116DyLwyihU9y?=
 =?us-ascii?Q?sDZikwwxaBu03H+cXFsW1fcxC5nMpZWTV49UPNG7Moao+NqiTWgc6J4BVRwO?=
 =?us-ascii?Q?JdAPAZXhxdvFHwHH5OQ/tydRwUpCtdlm5dgb4bOPDbDSDw6sIlMHNxpjI7B5?=
 =?us-ascii?Q?SzweFDYOMy8dvF9reioA67RKzXUePfsp+0/05Xdl/uNtIX8umQqulKOHy036?=
 =?us-ascii?Q?z8HO/ByeZbd8D/lw7ggr55xiYEbcM2HlGjnoXxLtGB1PSiqOiR663guScfY7?=
 =?us-ascii?Q?35n3bkz1A1mK3E6fUb7k8FlFZOWBj4dojefc06UrL2mX1gUucG1pYIPCPKhC?=
 =?us-ascii?Q?JrxjvfyEe0X2hFC7oS8qwEc0g4f0LojBVw9NHD5jYzVaPOvFBJHwC0fMQWJJ?=
 =?us-ascii?Q?/69mt0CyZ8xNSfA9LnQ+mVYOBe8xgpVsSj6AuXHgchycBhrgsrTDYhgQiAQg?=
 =?us-ascii?Q?pY/RBSvInYMWgq/iTPg2+IlAnx7CAN+dkyUbI2eBaJBleo7xuEbwdvOQEs56?=
 =?us-ascii?Q?URPBeBGFzwvZiXO43YykQkODITeBhV2Xfc3Ylu/AywH7W2wbBibU1BKxYaZh?=
 =?us-ascii?Q?CoujsSedD5YhrdcU33qFWmNsQ5TOt5ZYik9uVAGvsADNdgLH3j3w+OtFAIDC?=
 =?us-ascii?Q?x91Zt3RGniNlkLk3uYjzupkXICh4+HqkJFU/p2ovDr+aVZikKsni4s1hLINt?=
 =?us-ascii?Q?Hk3SAxJU1KJq6FA84PHHWumaBWegpVRK/kQtJIkrybWco1yGW5FLzwElhL6q?=
 =?us-ascii?Q?WAf+DqAikEspBFRbIQUaTmgBtXX54oZX7tMzLHnuJEoidK1y4A9dzw57+Dna?=
 =?us-ascii?Q?cVcyXxhnmguY36CkwBjDu3BgCvmTtpujzor0UCDZ6aMIQb9IdBNVcJaaYBSr?=
 =?us-ascii?Q?XcTWuKRoAwUZ60+vrOSgc0cgOm6/NWxB9DhqUOutYzqACFFoaQZUx2Wm0J0K?=
 =?us-ascii?Q?rN7EfCJmhOVBZvARsQRMEng=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46b1709-dd3d-4f67-7e50-08db516393b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 14:33:52.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6Qk7aJXKy3cMsp/8sgrF7caeF3QlePoZEKJ/rgeWxK5TUz3gMHGyMpdAyvIH5cvJrFyLgg9lx7b4eg8XIhv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
Subject: [virtio-dev] RE: [PATCH v13 00/10] Introduce device group and device management


> From: Jiri Pirko <jiri@nvidia.com>
> Sent: Wednesday, May 10, 2023 10:30 AM

>=20
> Michael, not sure if it is problem of this patchset or on my side but mak=
epdf
> fails to build this. With master branch, works fine.

This patch fixes it.
https://lore.kernel.org/virtio-comment/20230505163712.589460-1-parav@nvidia=
.com/

You can use b4 now to get this patch.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

