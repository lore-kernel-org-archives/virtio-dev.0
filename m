Return-Path: <virtio-dev-return-13339-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3FCEB64DD
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 56393419B3
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 499E9986653
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3AF9E986608; Tue, 11 Jul 2023 15:02:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27935986610;
	Tue, 11 Jul 2023 15:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL1ZdgI0uMa11CtBN+qGISbXPFRkyBIbh6TgMXCY5EyBXHiCM12u4oyMMxk3i1RYihheB3169/kg6gYocINmkMkDlAj8Djt0Z1trsNPWvM72QjJ9z5s0dKa5aWaau1EKDwsa+jYxzTwwJMJ4TPmVtek4AvuqmJZc1huRUp+dwqMcZoF4QoCpjc11x3m7EoFZ28Our9DjulLZtd7ghLDYPpO65sr6pMUlyh7wWXuSuLxHXhuUoryedOVfwpCPrr1fDWO3cMydHTN1NTd4H/00sReFIzGMt1pYIKECcTnKJ6NiBfbcLfMAcuZiRxzemu7jaXjDhloQHtoDaAH/LsCEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf2TmdVdJ/gAV2sX4D87NafuRoIiK1HzJENOvZf1orA=;
 b=Gn7sgaozfJhmOUi3Nox1tI8o1kIu0lTciJfhoT0QWfhyP8Ve7HQHwUwjKLBsf935REswn8SLdvBosv/gHK7UWFsceavLZBoQEYx6WAiQpHZknqVqFs4/kCQd4XYFDRtcNyA0tv/IsE+f7cKXVMrRQKKddYnCLpniFx8MSIuReK0OgCVOmwCYEKVYZz06LGMaLlcIhe0l8JwmddE7axu68XTvxOh7JMVOia0spQNlJqvSiPkvmyUv0jNtEZm+oiO+k85YKVQU/eOf6c+eUOOmgYZ+HeP1KxyFVLOcD72wxlUPxj/gBT9DLsdPWHuZe6u3CgXEyTzETyAqm/9DouNbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v14] admin: Add group member legacy register access
 commands
Thread-Index: AQHZs0ohnEJs6eqnNU6dA2mzKWRRUK+zMnQAgAEV8oCAAAEpAIAAYTqg
Date: Tue, 11 Jul 2023 15:02:35 +0000
Message-ID:
 <PH0PR12MB54815E538EE15424E037FA86DC31A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230710161752.204248-1-parav@nvidia.com>
 <20230710122502-mutt-send-email-mst@kernel.org> <87pm4ylspa.fsf@redhat.com>
 <20230711051109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230711051109-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7858:EE_
x-ms-office365-filtering-correlation-id: a01f97f2-ac39-41be-1d26-08db821fdc69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tG9ULhZsZPZUzEcLbhtqJ8oBWxVqduhPRteyM1aocwjt0djXlm8BtpjtRH0gJ7iA8eWzhF/8mys2gMcKlKroUMvFBQ54qq+OiiDyc7VOySl6qY7SnuF4JC8njjbnRKXGF8prkxpa9WZR5xC9E/cocfUEou8BcKavBlJimKa91YNlCRSoBF4HSaScsJccanFTVTmTpS6Hv8Fvn5tGe4ONPkupDa/jA/wbZKt/JjSW4lPOYuc8mfpOwItb00lmO5qPp8saitn1nZ4MYpEPYyAvndaJtssyLF67vKBZddvZjdFh9Y2iANhYnvh3fYNT7ALGWCsYYznjlOi06diixhqHLayNEEheR3Mz14phFFPtjANrDvfk+5h0iCYr31hb4Zs0a9YSxyYSwyU1VZ+wETLtz8s9SlDI8ZZk3yIoiCkyGY3qHfDyQwzYoI+omE+8EAIQz9hWXhXWewhBfIegRbhfYa634e3mIj5czkCALL9l4/w846BWHZma250u8aOsXsWmjsfZUyLuh1yBSH6P0YBEWCs+LoWN0GYEMUcX9anL0vd2L0pcrZ+zk15Xfv+jjIUQgDS79r+zXxblsvYS6DwQlDrKL/7q55oUfN1pCULLm9FSObI8t9EltQikMp+Ho3zD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(38100700002)(86362001)(38070700005)(33656002)(76116006)(7696005)(110136005)(54906003)(71200400001)(122000001)(55016003)(107886003)(26005)(186003)(6506007)(9686003)(478600001)(2906002)(316002)(66556008)(5660300002)(66946007)(66476007)(8936002)(52536014)(8676002)(64756008)(66446008)(83380400001)(4744005)(4326008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8wF7ruOwtDIi2TfFUbPEAtmirKXHiwNqJ0WmPluUauUzhf5CtvAzgmugM1LX?=
 =?us-ascii?Q?x4RY10Hdq6dXZwfMdMtL0l1xodJwWEqUjVN+707ughfyl0Nz22VkVCT0qt50?=
 =?us-ascii?Q?mIm4Mz6ePP9UE0O9uebpMDo300wgloqElBOuObGL3wDS21SBcpOFtZ3FRtPb?=
 =?us-ascii?Q?aoXAq9wxkHbYeN8/uTAB59RTC+JtzLUXhOhGzQ/bP4jvHRK1NQddWlaV6Rl9?=
 =?us-ascii?Q?hcIMt9/1S+z/SsVtN0y729W0oN/93naTvfDvcKbO9aE9NjCO0M4zLEDM3lHT?=
 =?us-ascii?Q?FD6wiZMUf5qJGyMY1IUEmdexU1uins+IZWFky7VG1t0Q4mTNVmsJ3aKYb3xx?=
 =?us-ascii?Q?lMbwMxum6j5TLgVUibFEzpxqBjciTg5rLSiDo5+rqpY8eJnQxkTFF6Eijz48?=
 =?us-ascii?Q?54NFDe5ooI3cuHoY0J3Yvncg1PjeJtPAhC0mDOCPy/P7RLH9RQlkPQFvGrZb?=
 =?us-ascii?Q?cJmyyMO4UJH82stm0ngzbmCRGoGIh+edY2G5L09owvwb5sZwLGV6bf7wL0Mv?=
 =?us-ascii?Q?/vjJoO4yCR7hL/1JGEdLSZiw+foq7YO6IJGC708O9MI1xXjPmk3pENs5Xhgc?=
 =?us-ascii?Q?/3LQo0kFDTpSurNbmkz9F3VDorWnJ/MsgwcHQJmIE9Kqp9CXwWPniInPCOtX?=
 =?us-ascii?Q?NcDYVmnPLYPblOsW72orV0Dftj5wVBTyB75I78VAtT7ar/kKBoQLEl47b2jx?=
 =?us-ascii?Q?QkLXEXvDF+IVpBHNkewB7LcekRgbFdbmnpxLbHnf+MREyTXhGK0kzTv367GK?=
 =?us-ascii?Q?Q7MmuWs9RaGLdnYtAOa70mA0HPOpH/lM44SO9/22EYHyDF9Nq5JG4tAvQgVg?=
 =?us-ascii?Q?O61fEXft9taADXyqJgOoks1mO8Hx7apDbMOJFrU5FS1f8URqUDA4PyHAGo8w?=
 =?us-ascii?Q?sWIKfe5iB8k50+o4/v7LLWR+8FxdpnypXiWt5OvcSNkKOp78FyTRqdtnt2Y0?=
 =?us-ascii?Q?hgNUkpwIGrf9DuxL2ii3qaTrUKXl2SmdOuviCyGA/1qofBUIJI2UNRI515Lb?=
 =?us-ascii?Q?z7TNWN9psyhFGkBQ5nRoIAoSfd6JyuY8PqJ6gN1FzTBNCAwrxX6K9LN/KTuB?=
 =?us-ascii?Q?InTyiWsP2C2Id1agaU61wlqcHYPoKawijjmExpIFDYzBbTd4EzMMDpylO+ZB?=
 =?us-ascii?Q?hbxRxj39yJXjkdh88DUu0V2M9dOPVrsEQA2rxFRBJKjSLo5pT7ml2JHFDeuM?=
 =?us-ascii?Q?Dq+2OVpFi07IghWGVV1Jd65QjP1GbnthH5SVT3hu1Loykf96kfkffsRSLLAG?=
 =?us-ascii?Q?S6xFCVrU0nA76nNq27FCS1W6YcaRe6Z/LzeZmY5IN74eGsf+j6kZ+MN4CoRv?=
 =?us-ascii?Q?oZLQYnkMCgy300JaZBTEwJlh3zH+zmg/JgP7DlBtDmZ9loptI+vipV1GTF/W?=
 =?us-ascii?Q?kgJRvolOnceaDWD4T/rzFXM6e/GoUru8QojBlFFTYbeAkpPl9T451L3XZmuE?=
 =?us-ascii?Q?iToWoYt3Wr1FRrsocg/bfpREcKpGSUnayQ+xjsG1qi0eTMdsOAjYoAhCPnzk?=
 =?us-ascii?Q?lhqjPOVsYa3huBJZHfMXw2Dq5IrWiZwjfX7Cr9CioDVWiqvNN8NPV6FmS+HF?=
 =?us-ascii?Q?Aly237aTMZ5ZFK7+x+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01f97f2-ac39-41be-1d26-08db821fdc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 15:02:35.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rarkwRALjGlpfOeuESG8qs5VUiQd7A0XvLewo2oJASkJBIQawHgLM6B49owa4TbugvWm6kY5osM0Ea1fjRIcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
Subject: [virtio-dev] RE: [PATCH v14] admin: Add group member legacy register access
 commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, July 11, 2023 5:14 AM
> > Looking at this sentence again, maybe make this
> >
> > "A \field{flags} value of 0x1 indicates that the notification address
> > is that of the owner device, a value of 0x2 indicates that the
> > notification address is that of the member device, and a value of 0
> indicates..."
> >
> > if you're tweaking it anyway?
>=20
> Oh yes, of course. Ack to that.

Done in v15.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

