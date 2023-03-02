Return-Path: <virtio-dev-return-11389-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677A0C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:41:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DF932776C3
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:41:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FD479867A3
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:41:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D21398679D; Thu,  2 Mar 2023 18:41:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70D849867EC;
	Thu,  2 Mar 2023 18:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyGUoOZ0xqEnO2xJjryT+55Bigdf/MYBf+5dJcapvSCy5xrsBxCCW9susyBJDKlCzK2beetwDulU7iT/pQvMuGwHKBo+RsLeY3q+ZKfXVNIMDJ79Y+HpB6Wo704zHA/YPo3C6SeYYcZYq4Hyh/SUvWP3PsgaV/cUT+DDqb0gS5UmOxYgmzkL5Z1TC7tzwGIe7Oq9OW4eQIYhd8Os//Oa4txtAviBhUtOlujj9GoggA7tMatg7Czlgdev7WqbdCO6clS+3KgUgM+7JtOGTUK+//hvBQOLnSZy+eiFPcFliAIiyABq/ydc3EPHtGV7p1tCXSKqd30iPakpiHTL9M8gNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdrItG4kT/OD+/DyfoFZktQsYK4FGXNSIij3bLL/Kfk=;
 b=fc540AQEnuonKSn4Fhzpss82PEw73Je6iyRn8gpe2EeVey4cZkvwbHohvqK7QUmhf9VCfE0jlGfWkq2Nsm8bG4o61WQdR5TH/uoGTyIURocwqgQygazOUDvWU2MDMhUaQ+ns1CspcTuHBw1fKiQbiyCf31gYNTI1IiftZTovUrPUIXGccTX9zcVBI90TRDDz31DdTK6Y+1oQZ/K8cEJXuEMHbq+2rO4RASczSB/gbrYme+g7L6Kd4O7AqVBOBoIsAnMAnRIAstYLRJanrNTsWhAltGmO++xhCMXb5rHJH3rbHE4dG4lc37MF2sdgk3fV4+l3XyozACOllvFHo998vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 04/10] admin: introduce virtio admin virtqueues
Thread-Index: AQHZTQegoqm3ZFh/hkOgShx3CSU6867nz8nw
Date: Thu, 2 Mar 2023 18:40:42 +0000
Message-ID:
 <PH0PR12MB5481561C65A2FDD7D38C0AD9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
In-Reply-To:
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5335:EE_
x-ms-office365-filtering-correlation-id: 7d786776-2194-4337-b378-08db1b4da0fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 y/wUbsHbSKafOdJQypG85l9VtkezTqAORivRbN2/USrlL45TIY+4AfJutwuG8GOtIPppD3xO0ASRxji7iqwD5LhEgnvRuecd3uvREW9RiFoKVvYYjfhFYeQAEQlHB/iLmaN5V+o8Ht8DWberJQQrNSB+SDBK2Mqu4pxAlZcYgyRSVfyXc5FN1p2zOg9+M7YuYK5l/N52FwlJL1WnVYAEi/VNP2orWx00KIO8ZRTdtcsOiLadh4UcHdhwB9ki+ezkeL1G15LKEUs8w/dlEC8102LjyoJE852O9pcaYRJwqwgIj+SW49ZfwoN3DXqVvm8Yn48pYqLf6OxaOptiqVcF0Ef4u58KozQcQ8piIZTyS6KHjHWR3fPaqr0fQsMP5jSwfHAOYzUrWfiCxP1aPVWPoL/7Wvw4v2mPIFdeVTLv1Cm9VXQdEAWkM7WEua7kwqCFuOaBiGBhTYTAviT/zkhWu5T0LQjyMF4ry2Vr1hg2vSaCrbj6pgYckfRGaJz/ZgI+ac4CZuvpsZ/NoAbuErM3y02wwbNAPrcVOzqJ5+i1XnZtNUoX5YwaJr3Wn31t9j0+Z67i+B68ghN7rUZmTGtAoBqprgJ7wB7WolVQHdmQTmXm4PqDGrbnpLfx/nfJaeoOSU1o1pabayNd7eA5W/+MgjDcnlLmM1bmnMr8Ou5sMjL/WN5wdqx6K1XCtWF5KJGfprAXXHCFN0Ca/wCl8nQG3A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(83380400001)(107886003)(38100700002)(122000001)(5660300002)(52536014)(478600001)(7416002)(921005)(66556008)(86362001)(33656002)(38070700005)(55016003)(8936002)(186003)(9686003)(26005)(6506007)(71200400001)(66476007)(64756008)(4744005)(2906002)(7696005)(66946007)(66446008)(76116006)(8676002)(4326008)(41300700001)(316002)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qUvVzUKk2jr/4egHxeVBXVejJAgm2Gt/Zu37gUk3/0GRWVRqeaijL/y0DAy7?=
 =?us-ascii?Q?M2FbNXXfciOIhv66Prztl1O7s+SYMYf6DJk0rn+0s7+Itk2siylLdkCwhDjX?=
 =?us-ascii?Q?MxAA7m0En/GtbC1pzP4pA79teE6JXXuOFGyED6v2hZN6hzuKBjiOKPdufFUZ?=
 =?us-ascii?Q?gd4jevfJnMFlzN2ukpu8lPh67fSqUb6HfBMC4hoPqufqac30tKCsETvY8/gJ?=
 =?us-ascii?Q?x+sRdfJpGil1KN1aC6g0EyP2B6K0T1zPD5Y1inDR9EihPl316MEjeXIxc3yt?=
 =?us-ascii?Q?GpFnlOe/E+TFKrMqdzOXzcfSzTOXrfGqiFHcfxdZCxn/Qa58fOLjU3Wmju1b?=
 =?us-ascii?Q?BLkzZV1AKx7bXTxwxSo3nllzgiaXL2QABSkvfaAI0dHoZrC1zqJV8sV4w1qF?=
 =?us-ascii?Q?9q/DtFrUbl9oHMvFMqCy5pEHwIeTbjmk392CCO4S0GCxEMh/9XCbtUiU5+yq?=
 =?us-ascii?Q?A3Dk5fx+guxdAGFWHnCTgukqCGsn0wIZKiu1EwEMRCTJ7UbQK4lO3o8M2pWG?=
 =?us-ascii?Q?RZgF+492Btq/4HVz23/cMmiHEfm6WFDpTa5ngpUruS2kxGs45X3J4a7OUKLz?=
 =?us-ascii?Q?oA5FQ/dxw3Uo10xeJj7t44dqi9sDyscHW0g3lf5l9pDdNlt1vnYdZh3UPbTc?=
 =?us-ascii?Q?VOgucg0cD7B+zK7fhDv1pO9MyPri6bIh5E6MLLz/2mWrADuqRIvBoDHu5eEk?=
 =?us-ascii?Q?XuCZTVyPbE5E6HagKZhPEVa8GlCfc3iBO505H7aEAPGoi8+5WSHIsmKFY3ns?=
 =?us-ascii?Q?G3YMlY8PGGHgaCqCjSpEHREph9GjkLKQ24yYFNAOW3nXzBZ7m9IvseCS1p5W?=
 =?us-ascii?Q?KWaX3c7Dha+aYwI3Me0XKxlXvoMF54+UlP8wAIYcPVEgvfgtQz3QIBeccZh6?=
 =?us-ascii?Q?++p3Qme6Os98vQom7rOthQL0BmSwkDZor/kyl6zfXv+Xyo1VkvE2CCCcudjF?=
 =?us-ascii?Q?lzg10WyekUI/dJpT747o2uBHEoNAJIwNNHSduDDkcXsbv3G1JU6QO+T/IKlE?=
 =?us-ascii?Q?znqlv+qfvUJ/98nDrDoMqf8pIZ3G2h5kw3dF1S+v7BmOSd57eJ4/1Y/7Lyyd?=
 =?us-ascii?Q?8lxy/5uuOSJUpWgCWLWu3cRNgrK67YlFJjSWkk/GknAZnX3TuhAsb+sExdM2?=
 =?us-ascii?Q?lyJ/Pq0b49X9wGC5cmt1Piwr4c316HsWpZcckbYXm/fghpGWz93T2gm4rMW8?=
 =?us-ascii?Q?1fU99elIDHmBZQHi0V+DG1L7nW71UfX+18MqwUH8OM3ObVM0eBEtBZCgIqVB?=
 =?us-ascii?Q?mKTNvBn7hhzT83BmzuY2y8RdqoO2kouAyCEc6Mvg9MMu0MFI5eKUlxXR0UEc?=
 =?us-ascii?Q?zbhpTGf14SXrYIyW3uQfr7x7rV2zQiTTiO4TpiRLq7tTLEaXKwe8qffmqlMg?=
 =?us-ascii?Q?uPhItzc41ke1eQoSZo/7Z2TFz/oyoDA9/Hr5ztHiS5mJL1DJSWTSazcy+qa0?=
 =?us-ascii?Q?cgIpgUtHdh/CIKvQY9hHbEJyRdmU/BCmSXAgsT8/vxuhaA5H0C/f18vaqZz4?=
 =?us-ascii?Q?dmqlDfsr5fSoNr8GXFldhYlssxWnRshMa/082c4wF/bGQvGMmHPkpal1i3DS?=
 =?us-ascii?Q?gvESSRwMBIqkGVkUCBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d786776-2194-4337-b378-08db1b4da0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:40:43.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnKQuJRl8PqdMNJhjCv2wciGs/oNumPzBQjFTxFlUiE+JGAOc1W4u3SvJVN2sNdY7sMBrjvEy9JGFE3K+iw44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Subject: [virtio-dev] RE: [PATCH v10 04/10] admin: introduce virtio admin virtqueues


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 8:05 AM

> +>>>>>>> 0edc690... admin: introduce virtio admin virtqueues

I requested to fix this in v10 of Feb, it was in some other patch.
This hunk shifted here.

> +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device
> + exposes one or more  administration virtqueues.
> +
Please remove extra white space between more and administration.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

