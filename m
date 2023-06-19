Return-Path: <virtio-dev-return-12980-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00032EB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:38:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 622D42A82A
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:38:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4944C986430
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:38:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3CB0A9863A6; Mon, 19 Jun 2023 17:38:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29A709863A9;
	Mon, 19 Jun 2023 17:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhxZDdoMjFF2ERvsZ+GnGMxO4LfTJsg1Q6CspqCDRHyNxcg8FPZolMoRYwOaZK9Md8x4Ysi+lqezcGNPwCqyCkbnQfRGdR1JkKyFX7iOzaz9Qjf/Jk/rbJjALPtrnU4jRr6SebKDck2qDaNV0Ucue/PjSkJLbB+V5zc72zWf73JR/kZcFFM4YwnLHXpBk6ZfUJozNWtRLxSgInEI2dWqNBwomLaTRKDQSQH62U5pg9YYJTvS0dMSgVBOo/9Ocp9PmoRnuDn7XMw94ef+YG3NJjZeekbW2Hzoiz7Wd6PZOe1yOu/yAnryKBt1/S1MmVHY9qebr+cbF3RCepdqRJ4r/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6UXab2NCISGxVFcnOvNXNePc0DxU8sRWSryGsD1UDY=;
 b=Wbbw04hKnT6sT+mTTB3+UGLFMtwXGeecIaihUOHWHPrvkpn2f3BCHJVnf17KjZYGEAKNg7L2U+ywHZbeaY/8GQPFjcrcIU2n4g6YsMzTuCSRwg1FXx7wX3Of+mluLhpGgZSg2spE3Eoq65NypVpDUd+0lcfS1ZtFSweJqL6npYpVb0XP/O3o3tezXNQNDLVa1b1+sfEaJfZsG6x9+HkthfM7YqtCMJlFxMLdnEPr5FE87r+0yAjnQagvCZwqqvi68YMJuBu84JcHVMwtqQFOkBsv8+kurFY1s9fNGilX13t46OY1Sm1W1HzS+cQvcZR68+so15dMB3sczeeXI1VtZQ==
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
Thread-Topic: [virtio-dev] Re: [PATCH v6 3/4] admin: Add group member legacy
 register access commands
Thread-Index:
 AQHZnhzNwhtFR5mF+Uage7sFrLqCZ6+SV8kAgAABfNCAAAQDAIAAAJdAgAAH7YCAAAB3IIAABbuAgAABEZA=
Date: Mon, 19 Jun 2023 17:38:15 +0000
Message-ID:
 <PH0PR12MB5481FDB1BD7EF9C26C699C88DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-4-parav@nvidia.com>
 <20230619121724-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EE01C25B4C170E498177DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619123757-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816B14CE2DA659837D1C09DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619130440-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AE9F8C823289DD17C7B2DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619132640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619132640-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7611:EE_
x-ms-office365-filtering-correlation-id: a6c91d4d-7767-4e4e-78b7-08db70ebf683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S4B8gm3N6u+4E4CFVcaIiPOzdhEvPL6wXVmeOl9QtvfByPeO2GWkuqtA7WJW/GpiblA2LgXgLa5FOI+aGa2h6AyVbzE8GArdWK/IKj/r4B0Ib20Z5iFYD/mojOb2HhzPYmFc8ASdnEvNG4DRw5cBPYn7XlrZ+S+wfyurRGOagmW7NzTRP8oLH2JzlpheZDVFBg9pVMAZ/U0Ma7Sx9J5nWKVW1nj1iiKPyEYbugByOMHUbQlTcGjhuoz5oy64LhIGeQqtTsA5CFNqFVwkK6gv+iJNyt91WD4iF7Evw/uic4Y1hHbHGHBHSodg0K7SkLKAe4KoXori0IeKc10mF8/snoqE+FTmhYW7VaC/q9ZeJhrbvhOEk1JqYrQkmko/9ddlG/wg3Pa7ipLjLjPlS7WpBMmBQMc02YfRa3HM9PcA4bpiDComhE8rMLdev+gy6oxcD3p2iGH6MUcIyg4vT7rjqToBMXsskEw6hFrEANo0Entfm8JBknxCABymtnEACzUPWyltVjckqTcVrqL8PizuKga2DCv01saAMA9qbqjTVE2yDtH03lAmPNwubo7aztY5u4LCxL/mHZwBIwF4DAh5Vr/+PoVjhUdA1MqgXlVtXkA9E7Roa3zcPuk+lftjr6+W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(83380400001)(7696005)(54906003)(38100700002)(316002)(8676002)(8936002)(6506007)(9686003)(86362001)(26005)(4326008)(33656002)(186003)(41300700001)(5660300002)(52536014)(6916009)(66446008)(66946007)(76116006)(64756008)(66556008)(66476007)(107886003)(122000001)(55016003)(38070700005)(71200400001)(478600001)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8aDfw/rtd29CjU6h2FTW2+07yr4/oOGiPpihx+Honkal4Vqcp/JP9qWH2xUg?=
 =?us-ascii?Q?yvg9ijh7ggw5AV3nAJqsXADNWg72fIKRIbIPAXcxauVG8ywatM8rWDgJKu+R?=
 =?us-ascii?Q?DG0bwWyyzpj4LzY5UXSqm8JNzUI9TNxhD4S3MrF75LdwM1u8JCq3UTkdg1zW?=
 =?us-ascii?Q?E9wOsNN5vr3J42PxK0YMYX7neKagc0RcyDS7RyFZ31BFo+GN4Dl+0yKv4MaB?=
 =?us-ascii?Q?arVTMEjJRjLwaZZ8ZORdA/xKRJWEFYoJJ6OM10qhBLSKjB8rtXCxdYne7vHx?=
 =?us-ascii?Q?tlzmgztxBXEt4IqDdCFoRo/70WHSF8IJYl2x9m8Cs5wy4xqx2s6Yv8X8RZmH?=
 =?us-ascii?Q?77uAIv9EFnmxhEOxU7BoHJ4fKqZmftf3sfgTH7CM/bS9T8uPl/5gA2ulE43N?=
 =?us-ascii?Q?i+zTzQE9nXEg8YE5zrQkTAPjefcf+NAMLF+JEumLR2gX84/h24Eovx57qeP+?=
 =?us-ascii?Q?GURQZrUmdv+uYjQ3lbt7l9Z+PWlQqILbvWFWyRHIMLTpoamEKPc0C2gG13vo?=
 =?us-ascii?Q?lgHCig/BUB+bDJTw/o91+HgHxWzmvtcvlPZ5a+ETdwj7rgZ7Nyq7YBX8hnhb?=
 =?us-ascii?Q?CSWSUrdgF9dDXUN21mx8r5ZgCgUnMjiovDA/uW2jtIZAJuDYqcoDeeTBhMlC?=
 =?us-ascii?Q?HCWn93oydfS2spXKs2aN3kXYVR4zA99LxN793eMlBZjebXgzNW5Ia3rPvo/b?=
 =?us-ascii?Q?Mt4smwttVSz4LOPOp/Z6uNwWCAIUniWFlFe6x+F5P+fdR3Gc8WabgFl1LF2N?=
 =?us-ascii?Q?e8gS7HUsFdWZNYgMX0ZamqtqHpVFjPpRxRqOiL1QgfGipvk0AQTihVN4Vasz?=
 =?us-ascii?Q?CBQZQfzEEKSgoSjCjWyHks8cPSZ2Gkx+++wZCrb+h67bPQ9sDzB1GLBDTsSG?=
 =?us-ascii?Q?4cxfbhNbdm+vUDubPS+XCL2vXbVbbASlcxKuK5d+TGIUemqIOM7PoyBPHj7b?=
 =?us-ascii?Q?iWzSIFCa0dYCi2me2G2ImOBRlzWqTqK2U3fJbGWaF4JnnuakPuY+I6aUOn+N?=
 =?us-ascii?Q?HWA9FTl4XeSZWVLCwPxzpFTnR9pUIgoxZ18ZkyTbbicbFUW4Y+IyHYsKjWMP?=
 =?us-ascii?Q?OUbbF2atiWqvjqirn+88jGscuG85z5ECDKb3EOMXjZ/7bp8cdxT0rAiziasW?=
 =?us-ascii?Q?chW1pJpZOMRsxYvnZq6yj+TkWFBMubQUpA9D4Dl3fNiKXbZsY32KN157BPAb?=
 =?us-ascii?Q?RFYDY2oQFfuOvTMtAhACApjP4tgxgivWAKTZz5iNvISuWzxF31RMHoLBeORW?=
 =?us-ascii?Q?fSMxdxeeTrXwp3INgCg4XcfBGPu12QSzXKjiK8Y/GJFl3TJ7oMArBQSOmhjo?=
 =?us-ascii?Q?tLVft/YDwaU/GuDY/stAxP1S5prp0iMDUDZG7dfI4HCmVU4j5HGMinTz2/22?=
 =?us-ascii?Q?oZ9sesGcME1VO0TgDDYVyPsehebKrhcmKjJA58w85CTtsMmDgyPdbFXqWkUC?=
 =?us-ascii?Q?WoV0ZwT6duCqzgAgEEl2uGrcIfpLE/8P0CX5/t28VkBcZuPAAjh36frjmViX?=
 =?us-ascii?Q?1B0iXaqBiyYUbCNKdNyKe2EDfFADQ3whqM9wR99LcN3Ao7lfesDAe7cE05Hq?=
 =?us-ascii?Q?WQhrO4rvx7wuWV773Ds=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c91d4d-7767-4e4e-78b7-08db70ebf683
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 17:38:15.8096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /T9PLS7+dlWjCMflvD+PRPtm7j1pKe+V7tNcVkKstrYdjlav6MBbCsR2l2UamRgwWfRJJsWWtndOnvq8mvJjGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
Subject: RE: [virtio-dev] Re: [PATCH v6 3/4] admin: Add group member legacy
 register access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 1:33 PM

> But I am looking for a way to keep this stuff as self contained as possib=
le. I don't
> much care whether the new tex is under pci and admin command section just
> lists commands and links there, or it is under admin and then pci section=
 links
> there.
Yes. On it to move things to the generic admin section.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

