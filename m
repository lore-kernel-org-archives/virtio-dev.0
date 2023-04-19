Return-Path: <virtio-dev-return-12300-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4EAC77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:53:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E13592AC56
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:53:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBCFB986435
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:53:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CE600986410; Wed, 19 Apr 2023 01:53:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BBB79986411;
	Wed, 19 Apr 2023 01:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyeE/8WqNYLgO1YG/1KpHqYPijBpLDfYc9oqetAHNPYS+pfLHjbuK/X2Ifuhm+FQcLEsdUfXVDQKUj09ctAHebYHQremX6PkpAd5KgnJJeKwRewnIZ5EG+n/dlir4e7jxuRX3BYTgbMRC/hnUSjEbXfXqlah5WlERYY0Z8Fs90yYu4LFHYN82ctdsiZhlQDxHG3quR+Mlz5Q2U9QyunR9y8fNW+BpNFs7mlUOZ+MZMZ7TP+w2CP2+qhFNp4F+TM+7a/q/LJ9WYUT5K2SUSIwj50lglMPvTuO0at1FU3+ZL4VuIc071quSuTow0foZA4Hw58n/5he7bGrWmx5sxI7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7mp69dqap7X7FCdzSSQg5Al7K4VDjF6mXx/A9tY2mA=;
 b=gQ8mIorrywJC99sHgBLtuLDYQrZ39DP9OnkEpSm0onpg6Q71ZfN0FA5FTAZYh+lrkrMbAPR/zs5wDfV56l8BL3xG4EmQOvbcqGiXPM8s8ndoMYvUUUFURsNXsYE8SrDhYx+DwmuByIp+m2f/nai/prcrJDo9Nngu0d6fbRFBD1hzLHJpPnnzdYmqAbOyqP9BGoffPxcnBRYGuFVAFJKBDf/w6d6EN9FfReQkZXRoN1jmgNAcFBa/5C4YSSEky5Pqb1SFWNoWMVAS6eI7FoDR8ICvQ1kAbXiyZWZh2NpkDAlz8LgBOuqacM3/1BmtrTDLMXEoYAET7zTmjIQIsMEfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 0/2] transport-pci: msix register desc improve
Thread-Index: AQHZbK3Pl1vZEnSu0Em+BYS7cGVZP68x6cWA
Date: Wed, 19 Apr 2023 01:53:08 +0000
Message-ID:
 <PH0PR12MB5481563196A477358D133ED9DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411194220.752355-1-parav@nvidia.com>
In-Reply-To: <20230411194220.752355-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8132:EE_
x-ms-office365-filtering-correlation-id: d3dda35d-198e-4727-4644-08db4078d2d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 56JulTZNF/11GcpqqBumy3SAEk+hWY2rJs0VbN4HikKgvdu7C6tUBlUJQUIozBzQaO1ykf7nNvFArt3DJvoWvoF/emqbv6w6uaF6W1m4tiHhbk33rK1kH6qozNEEOhCZvfYLhdvWe5ayMH4XhGSMdZ47Zy4kl69iTiOB1PyoR43Lwj3Xc3Qtnw0vK/OxXH7BkAOadtlwarHkXlwFq6iaYYEoUehNnt2sserUeDE62m7uSyVcrjLq/ObaD8oEj+jJl9+zKiDcrbMWK7gFXwh4CLSKPfiPVbEwZlPzqE3Ovr5biLpsR1mAzqdjGkvtA81dyvKMf4Ovgsw3nntPLVlq3RHTeOumpHN6mhMvRVZ3PmMEFCg7Z89Y7c0mvYzYmPNQZobX2gBJQ6Ll8Os7xF0POLfU12FsbTUG6yDcfeMmco31y2VvWZ636MSX7xEW1y10IgatBV+TNUH0ukwYz1PimMLDzF+2B4FUAZ2qqDx7+uTiOwLs6JPVRY0rSWAaMme6udZiSDByDFb3oVku/ZQO+Ngj95uEOqNEimpJhZ32FJsE9IbQEwLu9NBxGqB7F6QqVjplJ5rtlwdWsjFffvCPKgFU0ycdGLs++hyf9+9d3LM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(52536014)(33656002)(122000001)(66476007)(66446008)(66556008)(64756008)(76116006)(7696005)(2906002)(8936002)(8676002)(4744005)(5660300002)(478600001)(38070700005)(71200400001)(38100700002)(41300700001)(54906003)(66946007)(26005)(186003)(6506007)(110136005)(9686003)(107886003)(316002)(4326008)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2jA0wgYvLTb5HdQGAY8HmgQaA8A+9/zqaK0Bs+igVvqBKE2Baia3ll8mZfqR?=
 =?us-ascii?Q?Q6AxvQWPFhGSgDZuYlu1TXerhmTW2r7ikwhc4uRd2tk+peLdUq94QaHtExlx?=
 =?us-ascii?Q?8hO3P/qd4DjVo0Qyxq58qrfYOGe0UN867gbTtAJh8kt3qRuW/nv9lo3iftFd?=
 =?us-ascii?Q?D1T0Ehl5JitpS064IBZY2xMR+3Y/UTQEiW7GuVY17eF388pzngElDdNygZgC?=
 =?us-ascii?Q?VovxnqR0++nrt24ANGrlXNJc4LsxYTN5u4/63FOQYoe/OBpHvuhzvaJIXdRi?=
 =?us-ascii?Q?cv29ZqlnqL1zAb7kY+tRWDZ70hilOn8aJwhYYlOfQG+aO6v8wbINB/7a/ix5?=
 =?us-ascii?Q?GjBqyDpSFXVsyepCTCK2N3fdrLqQqw6DqH/lE1wivcfY2fJG20KIlZ0xxqek?=
 =?us-ascii?Q?7KLnkfwglbiSj8H+R3bx7lwHRb5TeIcnbqILHkOgs7oCuh+Hqnw7xhs8Gl2N?=
 =?us-ascii?Q?DrEhi27rLn0pNxZfUS7OqoMVilcX+/XVSPDSfylXK9k+rqJnprF7moN26iCJ?=
 =?us-ascii?Q?jCjLCwFeqCQHSyIhBVQTqdnMrVipllHmyHGeu/VdonXo2y2xXeU2vDr96BRV?=
 =?us-ascii?Q?Qb4p3Jsc2O4cfDLdTmzI35CCeUkaJUTqNUVpnulFIgDLTR51lLe1BEHzB71a?=
 =?us-ascii?Q?6gaDH1fKw5Vy8/3mdAxdWsjeNDPUzxmvqxz5YKeUoHYT5gcoEoWcA7WfEdKF?=
 =?us-ascii?Q?776LysZJ2HnyG0W8nTvLhvET98fudX8PZLoDm0z3aysVc8fSVLT7u5QrcRUR?=
 =?us-ascii?Q?/+SNHFY3hdxuk4mfsovM9+fJU2+JWALXXXmA3+Io5OIVUg5DXp6ZvWRrCwAl?=
 =?us-ascii?Q?BNeqpJiD6KqA+xU6jkOJUrQHrCKKpNJogrE7fBq4KPiyF5RqIBWRlFxH95CF?=
 =?us-ascii?Q?wnS/IxOe3hrImH4SMJ00lo0OhGmrfxa+uxtTPv6UFfGk3TIs/KqSNJBTBo4+?=
 =?us-ascii?Q?fgZU11nU5NWIfC4Ci3eDHmRuybHIj8KnJp3uKRkSkkzW1HatybRgc/63OuXh?=
 =?us-ascii?Q?BueULQRzobn1IHzbBMyfHnuJNe9VtL03v/DirpUv3D9EDIdB2yIWS1+y53GN?=
 =?us-ascii?Q?jplIKLdo23w4hYwZarSIw1knVIkgvfQB06ISZ/zAYtqK/3QmC3n3oscsjbNQ?=
 =?us-ascii?Q?zIa9KMVdZzDnc3Ke1l0F62AkDEisXsBvGkMtZDZOucm44Ga7K5eQDa3T+O89?=
 =?us-ascii?Q?1K65R0j7tP2VFTEgPSYmS6ibrMb7+HV6pwjBlGzWCRIh9qWKMFKGDqyQwxi7?=
 =?us-ascii?Q?mkP48JFR7dcE5WAU2UrMqvFXO0oQSOrFumSsZUIbNSBjhthZYLpEgCmwuQOD?=
 =?us-ascii?Q?wvj1jfK0cZ+6wCZ8pCVXz73J+x3/VkJdOb4Fx0NS7jPLdrcKsdFZtMUa/laM?=
 =?us-ascii?Q?q7wCONN0gpzKEHFim6nGRxu6u+8CsmFd4+LPraFr/1xLcZbO2r9eb9ezfJQy?=
 =?us-ascii?Q?+AcBV1dPN46Ih6M0tVc7Wbnqo5nXaz0F0J3NHShcfqOJJJyiR3wTHxg+6Ooj?=
 =?us-ascii?Q?HIKsC+iTdJkYrK/hGp4QX8PzRlqzt1CLStq+oEkwuXUHP256+RZlFCACMdX2?=
 =?us-ascii?Q?6HIZHnZK7Yyk04RpwaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dda35d-198e-4727-4644-08db4078d2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 01:53:08.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joFna5VKLdp0czz/v8heYAsU2W5xDAcPqtZnlUgR/kzW/2aDJtBjUwbYUhxcQEcHmgQGT38r1g04dv5ECgVihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
Subject: [virtio-dev] RE: [PATCH 0/2] transport-pci: msix register desc improve

Hi Michael,

> From: Parav Pandit <parav@nvidia.com>
> Sent: Tuesday, April 11, 2023 3:42 PM
>=20
> Problem:
>=20
> Current wording queue_msix_vector and config_msix_vector says "for MSI-X"=
,
> which is bit confusing.
>=20
> config_msix_vector and queue_msix_vector are the msix vector number for
> configuration change and queue related interrupts.
>=20
> Hence, reword it.
>=20
> ---
> changelog:
> v0->v1:
> - added 'here'
> - dropped 'receiving'
> - dropped already merged patch for empty line

If you do not have further comments, can you please take this rewording cha=
nge forward?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

