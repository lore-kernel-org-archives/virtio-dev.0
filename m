Return-Path: <virtio-dev-return-11983-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F58C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 18:14:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 79D853DF2D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 18:14:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D1599865B0
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 18:14:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 63C4598658A; Tue,  4 Apr 2023 18:14:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FC4D986583;
	Tue,  4 Apr 2023 18:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duqdfvS4nxnjbKM6JmZKurKvpQ3AD7hyX0EBWjrDu9SS3zgh0HUu6chmstT2Gloun9sEtrzgNQApiLDJI3PyckIUbYATsDykAsrcIaFUPY0qNRPuL+MlRXmVgfoCjqke7YfdpGYejjveGI34UCDyO8MKkvQdsoNRDd+o8q5LGimw2KCemnWiWCCYBW6tfGNpW1nMWY44ZT9dBD38E+YtQbW5lWJr4faQ9wg44MA4X1fPiJ2ITxnIxu4Le85Cgoao/kIM/CPbHGH19hbW3/7oIYIiV5eqK0QsmsxmH3v2YOebhJDYmhNrQ+/2QhacAO8CGKl9WQiPFj3bDPNbXJbDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtW51V1GtmkAqFgT8zKxj7XAHcUvhB3yUHrMvw44Qd4=;
 b=aVyBYx3PJhQRjDX0FNpgO7XZdJb8ZePTG/8M8lAtMxUs2O9CZid5549qnrId3m3R5h8lRhzrXYK6rZI2u4Go0xeTuBP0EAlpVEk1a3R0oJTZrsUHN+R/qdcjeZfS0B9hTKF9FwuD8DYV2xRMstQWlkJVTcYoe72AVmKdMYHkbdVv2ZUjOZr/GkpzlIeBS4aF6inf9AEtcJMCa4920oCkX/Jdudfwb/R6yqBR+13HzapoOgJzl36jLesvDOCATXGpHR6IEPBTL3PVTVT0S7WHM3vEcEx8zQx2C1K2xBazgcnLSjxy9+Su3zA3A44ai2wu3OHfd8ySOT5j8KzVf86pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH 3/3] transport-pci: Improve queue msix vector register
 desc
Thread-Index: AQHZXfD+R+aJwyaOYESQgcCnO4Vhaq8a0BwAgACbyFA=
Date: Tue, 4 Apr 2023 18:14:20 +0000
Message-ID:
 <PH0PR12MB548194B8F1C22EEB74164ABCDC939@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230324013534.280820-1-parav@nvidia.com>
 <20230324013534.280820-4-parav@nvidia.com>
 <20230404031723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230404031723-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6059:EE_
x-ms-office365-filtering-correlation-id: 90270125-c67e-47fb-7c1e-08db35386951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Kb90uuGzWBSRGuC/z/wagi4zOysTeNyXEM/cR0IxnocaPqnUWNd7wtE8ufxYSQQuhj4CFr5nQ7/Xbi7OUSOKBCnKYU82szIuS//nPAvXNhhDYoIQKL+PoAJ0/X+eX5bPidvZxApoEZj/RFDgCTd0BjHUvsw5reHbBs6CmaWoxHSESD1AkQ8AT/uc+k5T2hmxvQmGzoQY27m826w9/4xJgbKaKREhHFrsDrSfsYtNezCHY5+/Ie6ENzcDV6nM0Nx9JeC+xr992r8q9SOMofT6QNHAYWQ/A/XjM2JQwA3tIWyo2iIZerJ7BgWnIUw5g0F3m9ePzppWLzj4ZQWOyhqbYJf5M2uYbUJ33zdipe7/9EOd3otFC9wqdnyyiHGLolO8J9f0UVxrHtd1raNOgc0Y5IYyCeecAjEQep3m+Rj0lOKwcLcGYM4BwMo2LMaajgRd4GF6IHEUzzL6EpD11mG5kxcJqz5KqoiAOLB3Fkf1ulHSwyAs055qK8juTiYsu29QKnrWtME49hzpXNiApQBApHuwOLvW9byk9nI9/Ec4tyhwBC+L+Mde8/56yDG+iKGo1ytt/p1Lj/sopEBrgV5QgdN6ieChwQU5LQQmzeWbeAfrvPeC+QUJJGLVFkJZdh/P
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(122000001)(33656002)(52536014)(5660300002)(41300700001)(8936002)(38100700002)(8676002)(76116006)(66446008)(6916009)(66946007)(64756008)(66556008)(86362001)(55016003)(2906002)(4744005)(38070700005)(66476007)(4326008)(71200400001)(7696005)(186003)(107886003)(9686003)(6506007)(26005)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zDeh9aWOSOnl59YuxGjd1sR11v0r+/Llh2cfxhA33M93DgmCkLGIwZr6Lblv?=
 =?us-ascii?Q?J3NOGOYpyY+O7OxyRq1UJWJmlu6OV92PCiyTXQBU5Ca/iHBSZTYCSpJ9lOh+?=
 =?us-ascii?Q?qcg06froeX1RseKR/uQSCBYLszD8i05dlsISKXQ8n22jVPuqQ4TLWk1q+50v?=
 =?us-ascii?Q?poVGbdhoEp6/C0PqYTSR6ZtqKYlT4o3zplWx5BBv/P07O0y5kFgNLR+ehw5z?=
 =?us-ascii?Q?QrcjucxitPmCP6cAXBao+qwqoxUI9SEzIHkbLMwQvRWla4a5uvN9y6bHd3P5?=
 =?us-ascii?Q?WqlpEuZ3m4gTZql09sXc14e7oPB/pz1TPOGD0NLMfU/J7x+eD11RAsPKgYnM?=
 =?us-ascii?Q?OwOMeKbDSly0U6eAZmt/XBJqCPXVwaO8SkaXh8coO0CSaIIK9wEvGNPxsaJa?=
 =?us-ascii?Q?qv86c3e3SmyqxR8ePG/BQelpMCOStGslEvZpnNBU0jeaoOD/IX5kErKJJ145?=
 =?us-ascii?Q?WwDvmGJV6K6nAoO3BuCW6ll94nJMVJvBCAKJAPdn2BMubG1yVhRUC76i6dfN?=
 =?us-ascii?Q?2dFSyeWr1qxS+MYTL2CH5VdTeQdfnFEYD8mtsBPG6vZcNACoCcMh1bmego+e?=
 =?us-ascii?Q?D6piGnYLytjwKGZ1kFNclfXF0ujmzqZeF0FrX9TOxdlLwp7PkfGmUcSiWwZt?=
 =?us-ascii?Q?NADr2lEkMQzQXctkpLerZoKru+1bzoSOdWUIpo/O4lnWWn+lVI0Jf/oh09Hy?=
 =?us-ascii?Q?lmSNX7Wxrm3ivj1tPP0zFwrB9zxLPGG8ZHGw+d+2TXw3qwypCw578jo+9kmg?=
 =?us-ascii?Q?hoZ6YB7hJddXof5/XgyrI8JYnfDDS/jcBYwIneaErl8sPhB/unTxkrsA0ocw?=
 =?us-ascii?Q?1ELm5mdqJCKxNov/7bEjsc+eQ8SJGckdBoifpfuaeYih1t9apyaLBp89WU0j?=
 =?us-ascii?Q?IhlZmfdG7sK6Yo/SEoLq77OLLnMMeTi/vpC99GGLF1BMhr5U0yjbPz18XxHu?=
 =?us-ascii?Q?hkNxn2SEsV0LTw7ogx72S6iFL6XYcN60jf3dVIh8h+oMyiBwtA0mEJr+9Mxo?=
 =?us-ascii?Q?rMoz3J3uu6qkUrqPSgz0Xe0Y4Pb41YYz+mDihxBt3AsKEGnzolANC0XqZiRZ?=
 =?us-ascii?Q?SULGE9hy6XQQ0P3P4y83jJsySMUI/fNoOkR8OBeWn8/zOQ0vkJPZ/YK46e7i?=
 =?us-ascii?Q?C2gOufVd8zTxi9TfDt+Hy7C+nRzZJrQIBfw1J25jLnXCT8DQLD13I5V2zIvk?=
 =?us-ascii?Q?m/RqZhQF4ZROM7fvW1tY/tK2f4LES/osC8l6WxH/dntx4hxki/7G3Y1wX004?=
 =?us-ascii?Q?eQEB7iWuRtGlco387sR53//3WuJneys+DT463QqGGCFkxRHSjzKTcaL115N+?=
 =?us-ascii?Q?Yyix60FlTO2nnrnL2h9h1MD+nuv3IbX+SAx4zmmlEinTWp+9ATjwmiOvW3Di?=
 =?us-ascii?Q?0Rfk6dJguVqZD8RF4eK1tKFou9veV5Ug8fg2jlYnvy6PmWlK504abMHgjcav?=
 =?us-ascii?Q?KZC0TwvDBIeUScOqW3gJLosydWeSBOL3kisnGUgyUzBJRZUgbcVzcYOCiWfy?=
 =?us-ascii?Q?pB1pZZMEHVLjtUlYCHT4Uz2G73+r6WOagNx3CQtYZP+2waulgvsFcTVUKCPf?=
 =?us-ascii?Q?SlrPL1+kflR4mMbMXbI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90270125-c67e-47fb-7c1e-08db35386951
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 18:14:20.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axkiRDfEKjlLOjEHgoqzy0AtE5302smWjN/CZ0Xw/OtC54NYBvxmpcs11ofD2EwvjqXtNtSZxlIX5AZb55O9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
Subject: [virtio-dev] RE: [PATCH 3/3] transport-pci: Improve queue msix vector register
 desc


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 4, 2023 3:21 AM

> Ok but "receiving" is confusing here. And the verb writes seems to ask fo=
r
> direction, look at queue_desc as an example.
>=20
What is the confusion in receiving?
Driver some reason is configuring queue's vector even if it doesn't want to=
 "receive" interrupts?
Do you mean it is more verbose?

Word here "here" isn't necessary when describing the register itself, thoug=
h it exists at other places.

> Following that example:
>=20
> 	The driver writes the MSI-X vector number used for virtqueue
> interrupts here.
>=20
Since a specific number is used here, article "an" is appropriate one.

> would you agree?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

