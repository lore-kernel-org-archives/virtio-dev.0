Return-Path: <virtio-dev-return-12094-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB9FC76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 16:42:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 33F162AC53
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 16:42:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 177B29865F6
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 16:42:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0DBB89865F5; Mon, 10 Apr 2023 16:42:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DCE3198631E;
	Mon, 10 Apr 2023 16:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi3r8pu5L8HKc1P1pzi2Wh6R8IDjlS3NNNZDxq+wEc8/L9nIUEqVDGIsxgAJUPAPr6dDsCd1wNbvm/zANNviChYsZuujjOKWlxZRBHUDzNzLYQvb41N6/9PrnLMSFLEJCjLLTWc1P+M6mgWLpqQfpjOLq2Oud4nBb7M9cpNN24w7xaqnsr6axlOJ7agJq1h0XcA5M/U0iSHAxzL8bBoksVPJB5TaCMEw0ytNT2tkYA27DHKykpQliSW451cnuWraJHcB/0fiochiI4zTRx0rrrNQz3mmVeO7BGvzjq3a4DhAMdL5ybpQNPHIjd+oGdmSZICqZYxR86jqd6kBqAZ2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb6L8QvIPWTp/xd5ZTyBDBoJdd/eZMuXDsvLlcDj0ic=;
 b=AYsdbOFEcSX6mMPyBNuI7uQALQzCqu7acsnGDm+ighML0reJSbQXMye1XGjcYeNVcMz/dAIoPoJV55QAosRP4vTkNt/NrNsfD1hHuWLXEfTS9ozSqdgHhJSFGicOk/zVzAfE1NRGUlc7ARmQm1yqWpXqVG5Hlcipb/YtwXEimt5+W+oi3rBbjw50TrL76562yYJLaGO9Dj7kJ61hQ3OnEHyrrtgLVcbbjhAzigwVKSHeH7LDkSs/MYAYgdGLVBaACjWDOUz566TH29zt5fOB8w0EJ6h+SGc3yf8U8WJkNET/gEDSVZASchphGSR2efzMVyXmDfGIyEVIcmUiDUGslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v11 02/10] admin: introduce device group and related
 concepts
Thread-Index: AQHZZj1ver1WHL1zXEuTGOdXvhU8YK8dpx4AgAbrtgCAADTm4A==
Date: Mon, 10 Apr 2023 16:42:42 +0000
Message-ID:
 <PH0PR12MB548178169DF16AED534395EEDC959@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1680533760.git.mst@redhat.com>
 <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
 <ce6437c5-0cb6-f1a9-d978-b8084c95c552@nvidia.com>
 <20230410092304-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410092304-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7950:EE_
x-ms-office365-filtering-correlation-id: 766dac58-5241-4b4e-ea1f-08db39e29a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m9LeXvqi5mfnSaE58UTLS9ot7NqJOb2c0/GeKBQYhmeqSzmg9s7PBiXaTvPI9yw9EFrtkwk1foAKhHKXOibbNmAx0M8bUjQh865IK1EBBBn/3wKNYNEmWPlYGO7Q+1bJxyMqv7cVYodfImDMGSwt4pjZgYOXADANPKuKA36AuqmwKEOB+P06ni/65yU9f7iuCqZlVOebfhJRkEk+jDwGZCj6d7GOejiP1qwNtxIV1qMmV7iMH5bXeZv1am0www1SbFsV/2DsvCsQn3fqAHhKMK4Rb0DbMDAWB/tFPayzvQU70arbipaaOn+4uX8311O/yMToGOb+JCZYGifL7n4GQBXsoSMVttvXBqRWGju3JLJ61667weOeQaRYFuxcEuzA3Qek1yWew/GiJ5B7FMlxUm0dQgpem56/4u1uBjf4f/iYKGIXdRAJy4TqJoe90JoDT3s7H7v+d/C1KmH6ObMl1k+JohzTt4NqZEc5pJsJdk20wvvPO9KfCZsYyZVc2zpsUf0z1zhgjD0xvL9Y7wFbBb06dPWOVas7ISiIKLXkW0+MKzU8/J8VEyeF6erAjnfo8LESgGg9jR7/v8ftRQCnYK2MhWgx/altVO0OKvhw0NktbUz00qqak6uFZkhsPtMr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(7696005)(64756008)(66556008)(6916009)(4326008)(478600001)(71200400001)(54906003)(66946007)(66446008)(66476007)(8676002)(316002)(41300700001)(76116006)(86362001)(33656002)(107886003)(9686003)(6506007)(2906002)(8936002)(5660300002)(7416002)(4744005)(55016003)(38100700002)(38070700005)(52536014)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?deC0OwJu1jB1lcXZh+xqWuBMMhJn0NeTW74Wo91r20lmbpF1ZPwBG/wUpgAX?=
 =?us-ascii?Q?zmDe1WzadKu0CBHrI4u1P1IMYqQ7VRtVZ7VluJTe63Bz2us8BYIHpIuMPcIS?=
 =?us-ascii?Q?t2RUfa2MJoEyrHeYrhnX4/ppWnPEQvdjCIsvcKaTn5oYnesxXf/ZacM1z3IS?=
 =?us-ascii?Q?uBoyEqjVwBUMSdBSbodOBQ+PEMsCQCaDmVev5mayqkaPvz8dCvzjGHKKQJ/4?=
 =?us-ascii?Q?0FxqrJtrJZaHELVr7XH4n8CglKWaC8WNXZ5949LJ18pSNcVsGTnHvQFu0p1c?=
 =?us-ascii?Q?fHSHBx9CssLoyF2g7oo2iKPQR7MpTqe76hF5Nsw+0I9EDbmUH8hF87BoBJV3?=
 =?us-ascii?Q?MKl+4CsMsgWSmGr+xlqCn1jEOQ66yrvzgzx8ZpRP0apVRPmtjWPBoioabZzF?=
 =?us-ascii?Q?9w+L2PQtPLwZggn0HBcDhb2NVSgfYfzc/U07IGF8zRYewQS2rFSPW746PZzR?=
 =?us-ascii?Q?L3UZnjV3yzD4j6lJ4IwmHXQ1/sU0y+ssKVOgJAop+KRO7fGKt1RQJYlNvfFN?=
 =?us-ascii?Q?kGdwgkrWC+KyCtBUvnIgu1k36UvsY5DENEWa35rgUCYNiPJ3Rd2FfFIqe2F3?=
 =?us-ascii?Q?zYMU04auKk19vLohq5zaeOAICa9WioajRvP2vENCaxfpjlO3vggOBWzCrioD?=
 =?us-ascii?Q?UKgtla23D50JLBp5EcM8GVkZH9FuXocwR9uPMrxVYHnY6z6KgH7aqZ8JmXKh?=
 =?us-ascii?Q?UxUSyFAwzM29cZfFLoKcSgbPOdAXVZ/sOXVoqBLodfq1A3IIBFkQvFj452BR?=
 =?us-ascii?Q?9pulatHrBxA1SimkjG8/8aduxu+CpgQOap0xRLHrzXyLcU/j5DzbBRrPv6nr?=
 =?us-ascii?Q?1yBJJ7QYRSg4h9BlIi1Wg6W2SYxTskhD+LDb4M9BsgveCx8hU3/bm56Q19nP?=
 =?us-ascii?Q?wdL/htO4U2/meyLu9Dnx6YcoqT07g2Q6yRoiZIm5Qj0RtwMBmkM3o+5WTaSm?=
 =?us-ascii?Q?QRdX1cmGv/pzwnBVSdHkstk4r2Hlal0X94hIRABR9vnSvaqYzOmIEtOABB+J?=
 =?us-ascii?Q?oz1U6h3la4praMO1ZkdR6DkHgz5EF9Su/AQugANTqLoOdVA/+gd8lhfd+Ske?=
 =?us-ascii?Q?dnMrKox67LAqaxQaf6o/seU0nfbbToP6VkF07k2T455AOAa43fRopVtYvr7H?=
 =?us-ascii?Q?eXAL/cviybbyPOGNo/1RDkthsSG9TK0nV3asm7q/gtD9bLiy57Y4mFK66wML?=
 =?us-ascii?Q?+Zr0PFuxhhethbcSHTepENV3V4fUOfN+5RKvwmJk+PE7YSkOO4/Z0Vu9dxKr?=
 =?us-ascii?Q?77K3XVrWVVEOpJhIa6CpbLYk4x4XMttBWWNLItJ4W3Wto7yo07kIyhDIGZKd?=
 =?us-ascii?Q?u/ZKyekZwKegO0bf4JS8KN3ZTyP7cedx5v46y5j/MRTE53V8QQMCqywRDPTR?=
 =?us-ascii?Q?tcQ6/8A4Rs2dlOdQfNu5S4vYsqk+6wDNONxfg/i6MhEtmM+gZbCb9sZaRHua?=
 =?us-ascii?Q?OS9haviuI98e8XGnFMgg7H/N9DA7N3d9FYg1GLZ4zjefKYWwrrGVgkW1xJ1T?=
 =?us-ascii?Q?nEndUJpsuW+53FcQeyDtrmdHr0iCj/J9ZgPPai92Xt2wD1Uu7MzMVKWrbcv9?=
 =?us-ascii?Q?1wlgZT79c0HQtGMPCy3if4xL8IutSOKcnZFiFy45CbZMs4ntJ3BdJ29UNVjS?=
 =?us-ascii?Q?LchgGdo8IS25lygvkknVi3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766dac58-5241-4b4e-ea1f-08db39e29a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 16:42:42.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbGTJFUBlKMhG85fa2TAfsdCio2KsbAqYPZVycckbSdKTWLBKmYEWur623CtcRRGg1MLQ+P0u24jR/2qQxs1Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
Subject: [virtio-dev] RE: [PATCH v11 02/10] admin: introduce device group and related
 concepts


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 10, 2023 9:24 AM

> > From this point onward you can add,
> > --- line. So that it doesnt go to the commit log.
>=20
> I can but motivation for design choices is a good thing to have in the co=
mmit
> log.
>=20
Yes.=20
Righting it as
Usually, I see those design notes or rationale written as third person sent=
ences.

Also, since those design choices are good to capture, can we start cover le=
tter commit also, which usually give a complete or broad view of the design=
?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

