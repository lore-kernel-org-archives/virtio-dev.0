Return-Path: <virtio-dev-return-12969-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB0CEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:45:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0DB8860088
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:45:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 061BC986510
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:45:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF1D59863B0; Mon, 19 Jun 2023 16:45:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D52AA9863A9;
	Mon, 19 Jun 2023 16:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGNnuE4Oa/avwVtrviSyWoYbU493mlDuCVdyY48s7FqTlLLL0Bstj2QNt4Ivs56hsyGlWs9LJZeK8XwOGEkvRc4bavith6bJdqu4MvpHS2iuOuJfQni6tv4nErgKQUTG24pBw/GGKea2edjaBW6z5eyLltRD3bLPuXWlRAoRCza+PcE5LZ70iLkqiuDx2YDaTlM+y4f5waa+tacRX6+L9vsRU16NUpak77qYBwrV1aU+tZdskJSb7D0I/iXF60sBdM2YajPCd2UxTVlFqVJooILsuybxh8aVet4xjmWu86oEI0Rn4Ki69ZP4KkeW43wr5JwzSgRqJqK4vXFiSf+SLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzAk+FQP65MMCfr3a1NPgozD4v1gCKdNFFHmnXOQGME=;
 b=RjdA76l/JKQ7FUbf+U9mQQAztCZ1ARTGU5L+/uiX91BPYGfbhTBhWr3S5xvfJN83ZXlQaNU68IyuRymCINdtrOKvI6vtQgOF4rpi92/uwBSpiMtyo7eORdUmt1P5eqgxqxStXulmVYjoq9fUorRG1lWuxJ2MYD4pqAJl+39cNG8uKsfl7AVUBEbeXUg7fi1XP28tgTF1Cl+z20Xw7BEt54SwGUdVNQC2cM0NRoEZOv4KYYwWKAJ6tYU3QCGKJwOWf60GjxyPWw3r1oZT4aX2g0pvHk64I61bcO078kJiDndIorxJbCqzzhKJZmsBm+RwZu/KO4q9BXLuDOHx3GymIw==
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
Thread-Topic: [PATCH v6 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZnhzNwhtFR5mF+Uage7sFrLqCZ6+SV8kAgAABfNCAAAQDAIAAAJdA
Date: Mon, 19 Jun 2023 16:45:23 +0000
Message-ID:
 <PH0PR12MB54816B14CE2DA659837D1C09DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-4-parav@nvidia.com>
 <20230619121724-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EE01C25B4C170E498177DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619123757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619123757-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB7597:EE_
x-ms-office365-filtering-correlation-id: f9bb3f73-180f-414b-191f-08db70e493ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rYEMFmdLFqzuBGxIO/MM6NRJNU0C6KX9WjV6bts9vQlIUO41/5bLMjS4tgh98RwEdpR5cPyCYQF2xtek+ZhW5i7HwfS2d5+BaiXJ7sFhaaQK10z5upSBUIyl7v0k+SfTri47Mf+qHNyABxx8YD1TKXEe4FQLFqoBKJYkcmTzImSMdvgBsrtWJo8+JC5b3Nm4+sTAPBvqc6rgSg1/fOmEBrVJIPoLk2qL3/JM+tZaTAdC7fY1VKOdZHKMgIOPjLNEgwJFX3+ZJLSeSGKuL2uxkPYctKoFFDesiwdYYS6JFDG1UQS1acy7b5AkOFJC8S7akdQ79ppU3M1upFiv6PMzkZJ+D4lSozh+MLlmTyDhkNfYXMJ28YufwGWv766e+9gyucFZZFQ8KOTwn9lznWJMAHk5l2ETspJEKNYQd79ts1uN6sCSyPjRdcVwC1ciQyxDGdLcdtmPo8cZozTMOV8KTOnIlqnpt6+5BrQV7/nPICiCjqphcvIG0ta1k7taF76VtuX8ccjEWzMl2U3LX+pS0OaFbtWYUmWRNLNiRt0Gzku98Brxz2M1UVtBxNttgw0qklS4c5xzcKyPrXrfI5vIRKIdmVWg4st5fhKu00dR9sExyBGhzP0M3kJXDVG8f9jC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(186003)(38070700005)(107886003)(9686003)(26005)(6506007)(55016003)(122000001)(83380400001)(38100700002)(33656002)(478600001)(52536014)(4326008)(41300700001)(66446008)(64756008)(66556008)(66476007)(6916009)(76116006)(66946007)(8676002)(316002)(8936002)(54906003)(7696005)(86362001)(2906002)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h9MOq1Hc3ardf2vWMADS6ksLMpM4W/EfikPd5QZBrCbpmh17u8SnqdOXgWem?=
 =?us-ascii?Q?5i+EMdDcI1vyEiiTvNB7yhlXxtJDeHJ8ZFgMSccKARBlHkqJxSR3Y5lw88zX?=
 =?us-ascii?Q?S+ZOtTj7nJyci08KYy3E6/ltMMkVw8PLWRoEfl6MIdf8RLoVQ3w8uzOVgGF0?=
 =?us-ascii?Q?UdXE193ObXmv5pMtivzh4Lest95a6NNGTt/0J2LgTc5bL5xiSrh4Ldl1T/DA?=
 =?us-ascii?Q?uf2x9E/YjTGuryYtt/rj9GtBIsLELUWjDRm8kdjw72VEpV8L978GhRp+4ShR?=
 =?us-ascii?Q?pgw0RVXWhknfsukqW/JWcQP03rrI0qySBXIvAVkZjCTVXf8pKESyd7hqCSxJ?=
 =?us-ascii?Q?xX0UpbitrTkjgYpJMPm5TySg4RHKd3W1S7aCwUnoStcOngAiyMu+cPJywOXG?=
 =?us-ascii?Q?5Wz7aga8k122Rw/UDK5ox3QuSHTT+2bXtxX7nUTGLP+hPIBJSzcS0HdLBj+3?=
 =?us-ascii?Q?LA3TPMWg+mrKXBfif8SSWbdpQiX7o7gNh5CsQrOOFXhGZwkWpDgP9nUmm3iu?=
 =?us-ascii?Q?vov6tyTdLSWxIx94ldiAlPzy3wyNRhGewtg5Q+BnoWMGE+nzK5kvcJY1Ol1S?=
 =?us-ascii?Q?UUIJlYPHaYek9XvMEzfda5HM+GQRJWLvxuecOEWeLgcbcSW7u6g1tf3un4MB?=
 =?us-ascii?Q?Ii8Rlj9VXdVENiKLytP4rXP4kxrCTUJ+49GGOWp3qpCN5H9GTdUNf3M6f+hz?=
 =?us-ascii?Q?XiQiZIDnbc5tFvUphQIBCPl3MiTxt5JMtaE4Dlu+qXyUV4WJiYYNGQhA/ODe?=
 =?us-ascii?Q?kBXWRy15MzxGTLA/NX8I7CYkbTHVX58z4OcgxO3c8ZENnB9aARNA4T083m3K?=
 =?us-ascii?Q?ho2lCijjUKHD4uw8gE/9N8C4cNyajJ686g/daJiix6k7ofdxndDUfm2yfvzu?=
 =?us-ascii?Q?J+WeMn39E8aEkHNgcayMwOAGrCpPo+3s0UU/EZQj7lMZS6mz+oZamItNcQfn?=
 =?us-ascii?Q?1MeQ3ZTjWHsbgLzM8k8XksWTh+rzJzTikYhA1EP3SOpY73FQZFKkEsq2Fwxi?=
 =?us-ascii?Q?wQpg8Vb1GPTm11qni4AeoVcQ69LOMA55mQBmO7P29cVnVFcbJFW7cwKcmKFz?=
 =?us-ascii?Q?jYU20YkGZSQgY9PfmnijdPtFpbckzzxzNWWOSFC6iBdBW5HiZhDLtKZPjoMC?=
 =?us-ascii?Q?4DScEK/OUQPgdrhxw1w9GTJgkzPev82rZkU1rlLDBD6v82bmID9f8sU66B13?=
 =?us-ascii?Q?S9k1jR2v4QJra4rTstuAWsYzGXj9DYXTJe1KuJgFYl40KVuEeDME5tAY5mEP?=
 =?us-ascii?Q?dUfLIPLcGhtIrWCSdJBDzbd4LCiQA6JtVq9nvub5d1uu/PnXKNiG8h7haHRU?=
 =?us-ascii?Q?aK3wxMAxdcYNL75YJsFDTGzsvQO4rq/kvBJkYbTfLBLedfQ3qqpWs5ZzUtLU?=
 =?us-ascii?Q?IfA7EovbXR5lZB/fQMOOOy8Z+rzYhT6SMDe9koyfCnjc6+md7XfSq5ENwtlN?=
 =?us-ascii?Q?VLfsmLvdIpcuRulCV5WeNoLHTEwRp9+Jx4iNS3raQSPl3BDg+ql4mfKRSk4p?=
 =?us-ascii?Q?mNnmJsFvEy3YxDYzK+E2ODy/Xgmp9rS+WMtq0E2r20MDsf71pCmenef89iOK?=
 =?us-ascii?Q?YF6y4/2JwKhwS+l4KTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bb3f73-180f-414b-191f-08db70e493ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 16:45:23.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0W2UXkqGA5ZraSuW3GILUEmr0cTa1mSOx2PkFgr3TaHupocV01EeVF3zBDrEP5Sc0V9WYQ5cDuPcz0/BXeYSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
Subject: [virtio-dev] RE: [PATCH v6 3/4] admin: Add group member legacy register access
 commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 12:40 PM
> > >
> > > we can just say "the legacy interface of member devices"
> > >
> > What is the harm in telling explicitly what is currently supported, spe=
cially
> when it theory of operation description section.
>=20
> The harm is that
> - making things generic on the 1st try is the only stick we have
>   as contributors always push to make their solutions as
>   specific to their needs as possible
> - people are lazy and they will copy text and then I get to repeat this a=
rgument
> all over again.
>

The "legacy interface of member device" is a vague term. As implementer, re=
ader I don't understand what that means.
The commands clearly communicate the scope.
=20
> If you want to also have a type specific text, be my guest "specifically,=
 for an
> SRIOV type" ....
>=20
SRIOV in generic section doesn't make sense. It is covered in the pci trans=
port section.

>=20
> > > > using following listed
> > >
> > > using the following
> > >
> > > > +administrative commands:
> > >
> > > administration not administrative
> > >
> > Ack.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

