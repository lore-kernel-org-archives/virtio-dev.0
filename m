Return-Path: <virtio-dev-return-13288-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B3FEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:35:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E8AB3894
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:35:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D6A0986810
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:35:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1FEC69867EB; Thu,  6 Jul 2023 20:35:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 094CD9867B6;
	Thu,  6 Jul 2023 20:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpFuwoRH/uo0rZMIvZPEgGCFzNrYn66kzyeQ0e2hyzBD5vCfaPZPMEhflIgtQGmpK4i0ezr9gH1jG2jbZYkLyhMxawHowupGeROuOIpMnmMO79XGMyg2A5hIteERDhuhYdsLkhF7RnDvCLV56tpE+QMx0V8S5+OriKmu8IQC45ZkdOOexd1wcnUWsXJLYPZp1kTYSyd8USmdp2s/Fce0zgVrqcMLiOG2iO2czqJG+pDrY9+L9xRqtsEmNBqVbns4mdrGaWK+WuvXJR72hKTzHBHbq8w5lxslpN9sEkzUMTMW3egY0XyPGcLsJyegZZjTBcLbaL99fGLmYYJB0siw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99i8CGfN885eZyntEl8eKv5qjZzW3BqT9AnfNVWDBws=;
 b=oaP6otA+8IDiA7UAPmykHPn1nBXMZjNDi3zOrfpt1N8nDAv9jOcdU3zKcEiIWjy3MWzWbfzyIAL9CwXmelxlPLrt56WlDGo1P036rN5yUdfcZQdXOCs6L67EC0zvvODvsAZ2oYBi5pA4LsVwK4n4U9VosuUoLAnZ6j7Q+L4JcEgPQmeAojVZoKqz5xp6Ps+MrQcNUdPjKXQIy4F0ABIexidS1139o3utc1b/TG63iP8DkR4ZkP4pFEcYAreIOeaJiQz6AUPsxFJjaBPMEPqEonwSFFHgdCJi6UjFrOjykqNHWjKGjQRyNqF3fXebqTuweELlz8VT3wq3ZpgHiiprlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7AwgAAKzQCAAACqYIAACE2AgAAAimCAAAs8AIAAAGiwgAAB8QCAAABNUIAADKSAgAAJwvCAAAL+gIAAAHng
Date: Thu, 6 Jul 2023 20:35:37 +0000
Message-ID:
 <PH0PR12MB5481B7E0DE415B1489818DE9DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706145538-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706154002-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AF3000FFDBA2CBA5D7ADDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706162505-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706162505-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7010:EE_
x-ms-office365-filtering-correlation-id: 489994de-0175-4ec1-3f31-08db7e608e5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nNGMSV448ZTB8HhBcB0eU/ZaQwZaLvabcquD1pS95UEXu+JTjWnDsSghOGy5WDwAz4q8cyRPQlbVjDGw4RqBOvp/Tu5UhSW+/IDcDEyk6O2TLc9SR8YbLfc91UJE8gaNgUwA/QVx/YeF8zrhGRZ6+UcU9U7j0ZtvVM4qcKCX1xyHLbFxgHtBIS5AbaUdxQw9tpBmqWyuWYv38RbTx7VSJwEEPw7W0NRoICgbZDtCUzBB9uAiBnAkoqxtAMx0rqVl0z0NGrdSsjwiDT9Dw0DmKB38Qi4ZstXb8lkUbsPw+rc0r2DAHfwAAyVeWogwSDEsOggYOR/Bval/KFfqII1cW66+hkSXzQUhpMcyYlmNcvyGptbegBAXRjFTJ8THtH6D2aBK6KYAmdEDZIHuuXOHxauhwenxg32q4HjNYi4piN5q9jgpyJ+znX6kfeSxj745ME/N2sNnTutkE1JCxvAiTXEPsgR6qPr0wWfR63JhJS7nzITs4MVsuCGjPZ270DxHRaNyaTOQ4J+KoJzV/HWVibzimovnCc3T9CiuokHKenIBpcjXcd1RL+h1s3BPTapJQO53mR8fkbCjiqiZeh3Td8dwBokdwDNXYsXaj4XJRkgLB784nCoknrBXOP7HTVrD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(41300700001)(107886003)(66446008)(66476007)(54906003)(478600001)(9686003)(86362001)(38100700002)(38070700005)(122000001)(7696005)(71200400001)(33656002)(4326008)(83380400001)(316002)(6916009)(64756008)(76116006)(55016003)(5660300002)(8676002)(2906002)(8936002)(52536014)(66946007)(66556008)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ftQCeofJB1BC28CLWATMP6a0YWqRmi3Wt3x3WVEzFmGHNr21VGCV+6tT+oXo?=
 =?us-ascii?Q?muNcGoxGaBTQ/FOfzIGPUNe+exTLlyiKHkIYNCf3SNMcY248MWe9tMKHeBpM?=
 =?us-ascii?Q?P3pfTDQEuaZ0p+L+kZHZX1sG6UaCyXnmLCaI4alJqchji4F1dNkVcIueWoS5?=
 =?us-ascii?Q?rCN/sWchYFlpjEUX3rXhkMlWOmV0UQUEdiKSnq1JCf7JRutv33mjS8rs+ilf?=
 =?us-ascii?Q?iMypHtaAimJGT6Aud3V+7PWAcEK2xNFBubO1MrNDp0w5DVfXoY62vgH9FgrA?=
 =?us-ascii?Q?x1l3Zv1lJwfF9QGXi2WFOqDvoxOQjjUm7KyRrflJ4qIyVSOo/0XHcmAdJngs?=
 =?us-ascii?Q?dTC+qsUbR9vP2acXbJAnZe//l05owN2RMd1Y4Fi30MdZvau2zPjO8Y3/9x84?=
 =?us-ascii?Q?clAXKHCuwkbbrxhLnZApjThKoEVD3UroHK5wNMf3ZXou3yQ52SjsY4dJUppL?=
 =?us-ascii?Q?GbTEVeeieKb04DuFfH/6quU3a5AvWDt1yjZfLsjLNIaiZpLbDZV94UQoru9b?=
 =?us-ascii?Q?ZFiMAVvQbYm+cwQoWzQELV9bWGXKqgbOzowsMLsjCLKlwlti+7vbTg6la/eJ?=
 =?us-ascii?Q?YpLY8YO4jQ953WlIXZ+7pygOCj9li589Pr0w3O1EPfcwq95pHcFJD5I5WZdw?=
 =?us-ascii?Q?zThe7DTQGGLBo6fIooeMeL4Iob7yNaI/sqeTI59j9HRq7x9UlsNNP9wQQSIq?=
 =?us-ascii?Q?WuQc8pR2RmExDhPmfn1cxZlU5Ok0ICaXJ6AHrwufNh0ZoS0A3YtNedA+p8Dq?=
 =?us-ascii?Q?23MutejrcHpsOJ9DOPEQj+sVliAs0eChDWa+BC2vz1Bdych4QME0Ys411SJZ?=
 =?us-ascii?Q?MgBxw/mvUwkCpa4tpdW6YDa+EnuIkSo0JyKh0PA32GmpQiZAWt2M/GPypjHe?=
 =?us-ascii?Q?8gNDjIjELPJ06mlqak1Yj9g7ErBKUURUHffpzSbq3EwfbsSb5cmTDRbyh+fT?=
 =?us-ascii?Q?Gjipmlik374ivvg1xM+6ixS/U/CV4nINlfWsAdJvVZHpHs/IEn7UphGlhgew?=
 =?us-ascii?Q?7WP4uKwxtFCGhs526M+oWviD97wQmGnm00fAuWDSEKRDcA00s//6DzOvSaYP?=
 =?us-ascii?Q?NEWBvlspEYsfCt4neuWTtrGUV5xDTTb44zW1YKr0KEhL89KjnvobPvHU2GKI?=
 =?us-ascii?Q?t0Bn+wjSP0WwXvidKcaXUXLIN5l3AXw/s6IGPQ1RzAZcpek880VKgq93N7NC?=
 =?us-ascii?Q?Daym/LGNLYDsh2PSLMXWodmdDn5KprlPDQwDRTyvqpWasGLcDkWcHmJP/lKf?=
 =?us-ascii?Q?l1OW4+JknJ6F2NaHeaM4uKd24YrDBl7GdWwhpmXwkZefF6yl5V4n0vGIWlHh?=
 =?us-ascii?Q?8sJMmY6R3nhAjQkL4nMBHYX8YnqitotBeeI6ssno5OgHR7ORFF5xOjI/mQw3?=
 =?us-ascii?Q?YkjbrUQaJ1cttsOeiB66vzzEXwppEFgDQRhrltZK1o46/ZyEPu8sPLJNd7Jn?=
 =?us-ascii?Q?3dczKYO2x72sCfL8PEDKbhYScfdp9EMCv8sK5ZtFopxbm7eb+XjCYtq3bW+x?=
 =?us-ascii?Q?ntlhBSIeSR2CK5IbYjAq7tcOSkQOyWm7nStBkWDjwThQQJbdpeC7EP1rtj0R?=
 =?us-ascii?Q?34uZDc3SI9XixYXoUSs7HDpNEJESxMcbcQwrl4mcRXXrIDNxVXQsOaFNUXB/?=
 =?us-ascii?Q?FifnaMhIPBkVDp1E5lpGrO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489994de-0175-4ec1-3f31-08db7e608e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 20:35:37.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Uk+gRHHzCSjVyKk/XFAd+sEtY34LiQBfXyGRYcNLF5smJIXgZVltO9LSma6Agy1CJ18nRiJDgUMm86aRIflTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 4:29 PM
>=20
> The driver has a final decision. Let's make it a SHOULD and then if drive=
r knows
> best then it has the choice?
>

As you said, the driver has the final say.
There is really no reason to complicate the spec for a narrow case where de=
vice cannot judge.

>=20
> > > But I don't see any configs where leaving this to the driver's
> > > discretion is preferable. If you see one let me know.
> >
> > In doesn't need to be config.
> > It is the environment that chooses which is preferred by the driver.
> > For example preference of accessibility over ordering.
>=20
>=20
> what does accessibility mean exactly? I definitely see OSes where owner d=
river
> can't access a member.
Accessibility =3D access a member

> So in that case naturally driver will skip the entry for member even if i=
t's first.
> maybe there are configs where member access is possible but is very slow =
e.g.
> with lots of indirect function calls?
> OK fine, but then it will be up to the driver to test and make damn sure =
the
> benefits outweight the costs.
>=20
> IOW it's a hint for the driver. If you like you can say it explicitly eve=
n.
>=20
Device doesnt know anything about those indirect function calls, so device =
cannot hint about driver environment.

Can we please avoid this over engineering?
Interface has the doors open for driver to make wise decision depending on =
its environment.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

