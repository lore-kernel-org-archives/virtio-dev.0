Return-Path: <virtio-dev-return-12795-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA21C7EE2A
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 21:32:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9920F120D46
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 21:32:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 91E30986484
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 21:32:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 85B19986406; Tue, 23 May 2023 21:32:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7090B9863FB;
	Tue, 23 May 2023 21:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QChe081d0Lw+gx0YZxmBES3hGE2rxNOhSRJbzJFgKpU+Bz9R2ttkRzC9hSQ/Wtr3edfw+0D+ZT6ZlpSQ6Hqm0i+haAeKAgpmEv69mk7CGI9mNaL/pLc9XGzvOkMnWE5I0cjWdUCi0h4FzBTYeutRgjh5e/3DIcmW704jfpOWdbqLbaKvOe2YXhRumQRysFSofQoPlEreqpFVKewByU6NtwCUOaQz7Q6TkUGfaTC+Zjng+s81FlOPuvvN1Qv3jJqif7xbwyrz5lc6SR2Bh4/BNYK8nxaTOIDK38bbtoWClh11HfNQtXLzInumSacUkpWT4oKKBmIoUgayK9t71NpCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECGwPahzRD/q87LesYhT0GAnL1viSa7NYBdr5uqxx+o=;
 b=bO98XjE6suljpr95F3Wu6MgDrhF+cZqs1wdo/1bPZlNF2Lubqtcmcc2iZcDn8980WomVa/c+HH3LCgyLijv4Vx14lJQn919NhYXtFyv9LE+o1ANemhyUNRPH1V6lbZVNj4p0O2QmKgEjChj4/+iFePQFkT6HjYsfp+10KiPBceI7VKT9hNAZEAnDlxiL61Do+o9B2itDYvATppDYnMY7+8ViQSgZRZ8ny7brHOfUIbyQWPfSE9YUHEH0vXsrTkbZ0vhpUbBdvZ5IpkWicIgOGn2YpUOeOQUiOhBEi3LbsgHCktyrXTMUX9hSKAm6UGiiS19hI6pqVtOz3YrXsYvw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgAAsIgCAAEhEoIAM0siAgAA15BA=
Date: Tue, 23 May 2023 21:32:41 +0000
Message-ID:
 <PH0PR12MB5481E89D0E5DD6F291F8E149DC409@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <20230515060641-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141439-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230523141439-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5279:EE_
x-ms-office365-filtering-correlation-id: e8c98065-9910-40cf-05d9-08db5bd53d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G3axz8vgkuPq29ZfgLDlnZ9OqZzxAumfJubjB0SPdL9mDiHd3W6av4PQMh7ga1CKaiiegXhK0uzK2Oq6f88A6tcgPBwwVNChi31ZyYVpfimtH8hEQfZIGuvyNApvt+TnsO0Eah8d6nVqOdzqL6NPtSLe77QLAdlFJvkeinH8HIb0JPtECwooDWc9wUlR2DPTsO8j36MqG1i2pYuB8ZkY3e0V1Dw91r6U6t6RUqBUXKC/dUMPoYHF153/wkV6076HOUF+g+Bt8LuY/xYGIaRo8kMHzRy8QutRa1z8Pelr19S1rBWrqUOTGISQdtsPT/7urSWeMMCkHwlqgQxWclNZupavOUgeQ3rWZ/n5M4vJi3tpS8GoKUp1w4es0XAa22OGZtIRkxzPgsjlIaQgFZcblMvYqS1Sr7qfQGA3TOYzTX37noc+DIQ5icJkSf8wESwXxi2Uwytriq0Xzt2KbZI39bnReJCU7Abvd6/5RtsjNiuT7gOwpp88zYPup+jPlX0IrGMxvjl2LM/lbM18FSAWNKW6iwNc7GvryfIKjehkT2jOp1Nk6fIDg7EAm4Of017TxA2JHkk7c9NqGr9T9G1T5/VpZpaSLEVmdZRLv/ugwdxKrF5DVbBpJ2EjXHWoJwA8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(8936002)(8676002)(52536014)(5660300002)(83380400001)(107886003)(9686003)(186003)(6506007)(86362001)(26005)(122000001)(38100700002)(38070700005)(76116006)(71200400001)(41300700001)(478600001)(7696005)(66946007)(4326008)(55016003)(6916009)(66476007)(66446008)(316002)(64756008)(66556008)(33656002)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v43CAMSIbChfonXla/6vCkiiRdiTg+hyCmlAq+KUt5JZdvE96vvAWE88iOzG?=
 =?us-ascii?Q?tCP0jVv4H8HBuegg0vN7OzeFmuIfjNOy9MvouKSUPjqJc2E1ySKjAlN40pIi?=
 =?us-ascii?Q?H/751be25QHfGQs1EgyNkq3KR++COPmktI3G8j/yDKr3ESto+6StxjLikPNW?=
 =?us-ascii?Q?RVuSw8TZ6f4h93QPAV7NoEYor6vU47HSanIaNiHs3hj82Sp/SYn4/4zodm5c?=
 =?us-ascii?Q?WERBTdxg6y5j9jUZilzMQlQjq13idFjbwY/VSnWyMIBmLb0dYFv6IyqVITXI?=
 =?us-ascii?Q?PHaMAhz+y5kVMvlbY7VH2hP8iGD1Hr75n7Qr9LvUICepK68RLJjswOQ8OiXD?=
 =?us-ascii?Q?eM1bicV60AUjIMrqUGAht6Cq/Dq2LrOOrAqEIbR2Ewd+Wf3xt6fZw3eT2g+c?=
 =?us-ascii?Q?HBcdSuYG5VYykvSB7r09sgpB4Ou8RlSvN1Va0/jIQv7on+twIcvwbnHXSB6P?=
 =?us-ascii?Q?Uwaeqc7AjTBDWS3bhbHOzIpVFFWXzz7WaP5ET/RD7SprCt1PORNUXirQKJyq?=
 =?us-ascii?Q?VKidCxXqPQXkHDsPge8Vu3dur+CaxGYgudL3iz/nDrMAq/mOzMtDDAGAl+pI?=
 =?us-ascii?Q?SCvZiQpuC1TQ5v+cSLtJK0ohdELMhvRE9nCM8ZC5Rl1QPc2Ou/VN86NeUOd3?=
 =?us-ascii?Q?mIq0fz1YlnJ2xf58BOQMFCGp+anN2NRlPncBaURLAJ3SuGY07ytUhFGUX/9m?=
 =?us-ascii?Q?PDkijm/FtqERYks9sDo/a6lZOrWigek9uqrDuPKSv9EUiS/8Ivg2dE5Lcc2d?=
 =?us-ascii?Q?vDQQravuuBZIoWU9m3Gcp3yYt0P6QD5C0AUoVmUS9VFXNXj5EgFiDVr/tNDu?=
 =?us-ascii?Q?vEnDNtCnwwx0UXONuM3ORQplLKZTjbzarI5rAiIdtCo5oKIdlJdgpsdVxP2e?=
 =?us-ascii?Q?C3NnXH3PSL+JWfdsENzf8uS9DOOw91cnK82GP+W7GjYRBwBI3Hxyl7CyOKda?=
 =?us-ascii?Q?sl5fnDAnVSnQSC25YnasVcyjlZkACKnFyBwK4ey4QqpIcv683DfZq+tbaWBx?=
 =?us-ascii?Q?bBHKZZ6n9HoOZG//YcbzSKcKsCrTpIyjZ1Pwi+gz+hqL75UTTMak9BvsMCes?=
 =?us-ascii?Q?2ebDFY/WZqr8gXtg+pmF/4hWvu9o9zvt0XsCnSx3k7wgtwtiUdgCF6T1WeDe?=
 =?us-ascii?Q?NRwAcrJ1q/eoe4abExJA+L8CQouhvc5XOrk42AfwqS2C5GDjgSlbBiW6p9pY?=
 =?us-ascii?Q?ibauozYmoDWdqThxjvAAwGD+rutfMdbSt/igJfoh88bOCssjWEeXw8013POl?=
 =?us-ascii?Q?lyNAn3BP/VQ/xxlpJyXMZSBjHZg3PQP4wyxnHev8ZX+TcT4+DOUkbKfrfibW?=
 =?us-ascii?Q?QTvMHLgebPcKinLxSwoJH1vVx6PVpyKScaVZH1MvmL7D68cHvQNp+nKY6FmH?=
 =?us-ascii?Q?D9mNtHrCoJgayVlooQ0z2b++saKZJSOpNX7x553Gz+yH3S6MN7IegUawVdnQ?=
 =?us-ascii?Q?+8TC/rvjCURnCBN/eyiXcgCxNiJNNwZmExhP1wQaSSpgK+GSSqfxH1jzqudi?=
 =?us-ascii?Q?iqWMm5SBffvKAi2ccKI1M2P/mdm+4D2phIDmOiSzu7bM8CrF8mVX0y9BzZkX?=
 =?us-ascii?Q?8Gtq+GyS2pWvmJZBTzw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c98065-9910-40cf-05d9-08db5bd53d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 21:32:41.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPo79Vh52v+AWL9CRzJiFC/KDaTLkk98bc9Bp3d4CV5VWHTtBXkJBOr9aMYZOxPJo9is/DtqiM264nGHb4sJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 23, 2023 2:17 PM
>=20
> On Mon, May 15, 2023 at 02:30:55PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, May 15, 2023 6:09 AM
> > > To be more specific, device config often has the same layout under
> > > legacy and modern. Thus if getting an offset within device config,
> > > same decoding logic should be reusable between legacy and modern.
> > Modern device registers are directly accessible from the guest driver w=
ithout
> mediation for VF,SF,SIOV.
> > Hence, there is no need to have commands for modern register access ove=
r
> some VQ.
>=20
> Yes, there's need, and some of it you were pushing yourself.
Yes, there is need without mediation of AQ.
It was discussed in depth cfgq idea with trade off.

> AQ will allow reduced memory with SRIOV, and support for SIOV.
Already discussed, v0 and v1, mediation via AQ is not the way for SRIOV.
SIOV starting with single goal of only backward compatilbity hence, AQ is a=
lso doesn't look future forward.

And your summary email, we parked it aside for now.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

