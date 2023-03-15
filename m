Return-Path: <virtio-dev-return-11630-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E61C7618D
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:12:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A5ACF2ACA9
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:12:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FEDC986422
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:12:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7F9F19863FC; Wed, 15 Mar 2023 15:12:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69EB6986402;
	Wed, 15 Mar 2023 15:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN6RvKxoa/9vhRPCDdpP50YkLTmS1+Q3hUCgMKx9ngHWnRSH9fp4SuyWUz2oIJ1cqFQs79YDXssOaY7tOwM1LwJCxiDa6zedkXpKzOpidv9/9d1Mo1JgK0BZh3Vze++BJWGqsb8oaC34zmlSrTC43hDmx1AnPpkS2HQQZ8VXGMCRyLo9ns8MOnpYefzGrqOglhQxxPGNt6ffStnCKdpDsejwcU6Kstgsn/0sQQ7ACamMD2kgy1GBnoscASe9ROwuQkJ66cB5sDxhT0Cej/EM2zw2d2uYFL30XAX/4O3T8ztq+8ZIya13vyu5lT8O82inlOTO1c3rFqhZ7+r8grAMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRpoghji4LblNBp7CgzOe/l3m6wibTt7lAbkXB2ZL34=;
 b=YY1ffCtcE6k43MC9HjurhfshFH6Dj+OpdkD+JlXPzLPvjU+x1j0CdOs3ZNC1SS7ANnELpWs3Cf17JTc+F5R++UUf/6dmqJBEiI4iE8dSrk85nXFvPyCQdQ8UaPcptyotj8NNZffCXfYxK8AjXJaQpueh8mITmfObv1hj4foVE8AQip50KnMzkjKADvHOKaPmtN0SNCva7nQmCjvWvz0rdBdQ/jnMUHq7XhtBbgoZ9Q32TvwP5FDJw2oRYn9sPx2EMf0y3kR3zA6+W3Oedk0YaLQKfq8OLDotmlX0jJR/dAt3lL29/jpFSzNg86gsf9TKnh7V74CmReapguqHzN2AaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout
 before its fields
Thread-Index: AQHZR44SBM2m5bVfBEeSkO5d+VQF6a7dAKGAgBo7NtCABMicIIAACh6AgAADWnA=
Date: Wed, 15 Mar 2023 15:12:29 +0000
Message-ID:
 <PH0PR12MB54814D7FF29839AD136D1FF8DCBF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223135205.175949-1-parav@nvidia.com>
 <Y/fQl7ImbYGHEtVY@fedora>
 <PH0PR12MB54812629987A9530712C0649DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54811AF45A8A935B17806632DCBF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230315110003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230315110003-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5359:EE_
x-ms-office365-filtering-correlation-id: 472de918-c612-4daa-eb4c-08db2567b18b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +FA4Ui4CfE3RJJ/v3MbzvMKqv/Dhxw/em0JvWWjqfsH6XQ6Wqg4jEkPlF5rPRCUNsGdNS1TDlcvoZZm57bNMvq4JuOewF/c917UMqXZ3lpBbKs1/XrrYOX7jjIyb/Ynb9oFDslj2HdCtHVGNrjMb6z2UCKHzk1RL8UzV/3LN8x8ohaT3TG49Vz9YHHnYXKJS8sinxi6lttkXP7qgS7N3HJ5rRWeJszamcIJZn5qHFGclOumzydVCswa1dCrnV5bnRJUTOzdmlVmLpeOp9OHcn4NhCkwzGayaTMhJutRcquHHVvPUZfmgnxS1EXAoXStv8tb2MwbhVLpUo5vK0m1quNhyd3S/RxJVfG2EXafRYJ+qJuPCT5+F9hjCJNs6pwl754OVUUVbxzSytObJmeird09BIpumCYjDUoCVc5XirHugQ5XXoTePRK2Byl9jEppCMUu1t0bSlIHJHxvSD7XbLRmiCJO8nTGG5/42cDNvFsZII04eXHjdL5/uPnoUrp/Zsg8XyvcxuUsasWpHCuPwvRaulXOw8xkd4lUyEF1++3a2EjPza9TCF7RPX1Xnu3h3hUtpvvkfv1CR3g6wK9dKon/IvbuC217R/i1ZQvRVjKOlFEG+v4yrWQH9k78dBUbfoWwAT/iREdiSALKt0fgWAJIOgI8yHZPWp02+lZOlRL5QryD+cC5iKmqpL5cdX64ENzJs43YEuJf0PSu/xKWZoA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(122000001)(5660300002)(2906002)(558084003)(33656002)(66446008)(38070700005)(86362001)(52536014)(64756008)(41300700001)(8936002)(55016003)(66476007)(66556008)(66946007)(76116006)(316002)(38100700002)(4326008)(6916009)(8676002)(83380400001)(54906003)(186003)(478600001)(107886003)(6506007)(9686003)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DiUHfXXZeMYAc4eHyVPZLfN0UzayAbwoxXz2CstdRiuj7kpyx7IOoyrj1d5c?=
 =?us-ascii?Q?LJ4jmS2fBD858+rMTsDm6/eECYrkv75z1slM8oE2ODQCS1Q3n+gwTUkM3rsX?=
 =?us-ascii?Q?xjC5vph0FRwOBsbFGGc4I3gygZsZ8LYzxGArGE4mknyjal27cFzCprtTfYLV?=
 =?us-ascii?Q?7qt1pfGtgrVRiZryGZOxoahH/kbDAtk6iGfgLURWMsxpGmGi8uZMBRR4POc7?=
 =?us-ascii?Q?HFUVNhPao2yZmDi9/q8BZoBCOrpEL/ARjfmQsvZJM2UIoInH7fh2CN2HQjpi?=
 =?us-ascii?Q?LbtSGVV3q15gXaVqfFkNJNiTXD0Hh5+DN92UqjxiLuipowJrkXH15X7kAcr3?=
 =?us-ascii?Q?nkw50ZDRuSpPDt4fbQfyCVMh+ruWqHY3xZGVYlVrkXUSpi4Ychv9obSRgJuJ?=
 =?us-ascii?Q?DUHx1UWfio8IfT4clqWBKbdsI8jMb+9U8vq2Xw9Y4AFEEd+o9Jekz1fj+zm5?=
 =?us-ascii?Q?fXOHuf5aQnkgOH98ClIGYDFhPUzQFHFw7nYOE7nlJAViwieuUYn82ZZTLQCs?=
 =?us-ascii?Q?BvNOQuLJqCoPYDIxprVtL2Klpag9wctEBeSrv+WsZnT5CHLP+iT8l1jkzF8L?=
 =?us-ascii?Q?/9sXU2BJG14PKSaW9ah8Lm7VpUiiChI/rg1jZ3Rih6KvEG6mKmMuTEQNQ8Zv?=
 =?us-ascii?Q?rD1fjsK1g+mMC0Fo2jbP1CnqA8pxWfAYLtPOtezAlUfC3Kds6Jab81uXlJlh?=
 =?us-ascii?Q?hZ0sF9tzXCW4SsG67TFdo0asq223Zcy0Xa9vxFQFRDabPYGfW53tZxbTF6QO?=
 =?us-ascii?Q?Lm1pMQFt3eFT0D0ngfaRXpZu/YslzoiJ0uDZ8m64DIo/89f0S3qcTjais9Jp?=
 =?us-ascii?Q?ImBOwqDzqHxnofGOP8XWhjGCh1b2hg5W2bEzEnizP9F4QWmiAgMvYt67DEXp?=
 =?us-ascii?Q?/neRbuWwqGs+vW5uMvVgcDBJ9Pa9cM7AkM8dF7/cylHWXHKREe98GHXhWgTk?=
 =?us-ascii?Q?gDd9647mJCK/cZb82Cls4y8UJZg5GteGOt7C4xtXdVlZWQ/XcOrKlB35gey8?=
 =?us-ascii?Q?Ea3JQ6/mVjIolc6/QtlJwU0Vuj2/pfYtE13+5teuiepmk4atSHJ4uK6kLCHS?=
 =?us-ascii?Q?na+xdzKQZmufCJBlK1W91vdr4o/C7nCj7RrlJNOeulTbWxta2emiRVSIYEKj?=
 =?us-ascii?Q?s1FoSo3pCtDR6KcUHymJRNlhzWSXPJTKGpzMNVxmWwZslJRmpF9K8cckIh/d?=
 =?us-ascii?Q?pNJs1K9M9QTCa1LS/g8S+pHkCaDCw7Tu+mTRWMwaxU9eEhCNOVqy/sDDHMqD?=
 =?us-ascii?Q?VFv/kh00P/gXLLCzqgeQ5U1hhoq8+5UAGDe38WE4wMHHOmanF53dzs1vS7Aw?=
 =?us-ascii?Q?xJDP1Lg+mTrhRRK9NlHQiJmstFITAhKBL0HgJfkErgsj1WCp0ltR5xdgVBs5?=
 =?us-ascii?Q?wNxyDp3CT9uRhL1pyMmZ9Kgi21DbrASRQ9JI2D84BDIgOUVW9UQUqkuegj/v?=
 =?us-ascii?Q?B3L5BHwLfL2GjcRO945XpwOLWCFCOTGN2fzyidXq6Byxni6nX2T7qpzZvJN3?=
 =?us-ascii?Q?75P1rjqdGil2VluTPoVX5ghHX7lgrxfJGvxB6PD1tMe5X81MB3V90LVMzCve?=
 =?us-ascii?Q?bGrVSw+DduETroAbyc+PBUuOSYBv2JaduWEds/4nf4eXk8vLfT/xLT0Cdzd+?=
 =?us-ascii?Q?hsFqGCxUHvaVL09x8JK7RM0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472de918-c612-4daa-eb4c-08db2567b18b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 15:12:29.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3GUUNlgbU2h/8Wgrhu1Mk/6Fh81yxN7Zh28NMCqexnFhxxEorhYRHiqOlB4CrG0C5+y+tr3P0jgW5uC1eWoCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
Subject: [virtio-dev] RE: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout before
 its fields



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> > > Hi Cornelia,
> > >
> > > Can you please merge this?
> >
> > Any updates?
>=20
> Pushed, thanks!
Thank you.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

