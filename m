Return-Path: <virtio-dev-return-13059-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC8EEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:18:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4419F16DCD2
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:17:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D7199865EB
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:17:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 306C69865D1; Thu, 22 Jun 2023 18:17:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B9B09865D4;
	Thu, 22 Jun 2023 18:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jery99ph0Wk/cmDfYPM3kQh5tgcO32uS8YtndvcZ4wF3QGmAFHKkAWW9SYFgX4Dn45PalntSu2S6JYAew/y9B40jH8Bn98piivuVoVey/836bKPk6XIz7J/D4/31w7lPQHCjx7kWpOToNgSqmcjKP0HMyF+iliUllf7aN/GZj2RbOEl7XpM44Xqx/6fxlX8Mrr5+BLKSvZQMqLV4G+ONgvhEoNwJvTGbVZXfcK1zkfH7CdmJ1dEwh+wEM/Jf8bY+jtkWnK+JQdOMNKz2xYATqVU1BmWRe2IihkK1HWZi+XdU5w1rJyjFFciAAkdXtJFeOjX5tjp0opc2067mxzxLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMHiseWlWDnTQ13oYmQ1X0fVtluppL3AObqVs2WViZg=;
 b=Jmi8GBujDE5aOl5er0Dq5X0JBr6kd4eExLNEjZp0a92C8RIGcRCs4gUs8EK8arNk+wYHScnB5Wts0oNQjMJKTzr8B2SuJXCITHgXl0GiJvGiUGeTPMc4zj4M1+GF2Fumbc/U7Z79pF7t2MxIlqtSS7EZ1XEQiOdireEcWgRoZAQ/Q1a3Gbn8bZbH3XJobs47lLlXtXMQeduqPPjD/v9M6OZbTDhG27jovI75bGdr+bVuxLMDQlAYcjW4+FU7whmUzzRYXZCa7amQeuxvZcUuX7LS5K6CIQOiRRjjDQBgaTWZiiQyF1p2NpRbftIv8p/EeWsssEqppmYrhVERta8v9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABRroCAAAA20IAABzoAgAACfmCAAAb+gIAAAMtg
Date: Thu, 22 Jun 2023 18:17:54 +0000
Message-ID:
 <PH0PR12MB5481BE907C0BBACC00389091DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622132837-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B65F624B16200B91B0AADC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622140412-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622140412-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB9050:EE_
x-ms-office365-filtering-correlation-id: dc2e3b47-2f35-4245-71ee-08db734cffa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6kj4MoZZqLTGw8Dyi62AlrES2U6EPoXinM9yUulUjoytPVgjwqmp2/ktwPiPsqu1Sskn3ukMy0NQmYEo4oLMU4vxWce/ITwntuduCtDJ/TTlBbynHfrRkCXyGqDTEJYSliZTzT5G7vOV/244EdBGDeCq4Gkk50rqh67sJp1VqqOg8sctyvd1hLV2B4Lbez9VsL6GdOlqlnY9rhS4kbjSI11/FsVaSoChqUWtKnrGqGS1BSIex8lVOsOw2CIVTp6WfGxGMVPouGtAiwi/6o6H6J+0+0iTjIAjbp8ImVdAKB1m8V6W0kxyr0aWtA5YDSuSoLBJ7Hg7dHJbOkJnByHwCJSKZWPW6AvW/z9TYnWCSlZd/bPmLQmAXhraSJqkomyM2OeunhOYrHK8v2AqQ5QsBh7g03X1pguDL6Ld0C3u/Au0/kulTtC4rN8GUf4bUL2Qn1TRg2tKuR+V4mxbmHzjiLifm+wVxBVKCQWDKEjgIl09X6g/V8DD4kDoLoMhk/U+Z2zZdzJxicvw23eJzBilaoBrJUT7rDnPL8BNUSXPPopBfY/65c/zt56MyO3A2zDx4/HdxalJZx5MooYTZTDtucBb00AWfLE3uaYv+G/o+odwrh+wCWs9mFWKrIDkiyT7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(55016003)(186003)(26005)(9686003)(8936002)(8676002)(33656002)(41300700001)(478600001)(38070700005)(38100700002)(316002)(54906003)(76116006)(122000001)(66946007)(66556008)(66476007)(66446008)(6916009)(4326008)(64756008)(52536014)(6506007)(2906002)(7696005)(5660300002)(86362001)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y3QE3bSJ3GbZbaDfjfdOLfI4pV5TaI/mjx/JHLjvMfZ7Mpg+wN3tLfbWAIc+?=
 =?us-ascii?Q?Y7qymecP3oYswUgJkt87x3ZCkuTi4RlMi4/jRks5GfMF0ZMQrfwFBG5MQG6d?=
 =?us-ascii?Q?W6d4oKcUpQ9pVxpFpYUFQ2llVbjjWlQ13zH/C8CLqoc9SmCyRSy980qM6+RP?=
 =?us-ascii?Q?jnpdA4P6zmjMvoBrmStT6qz/dXGpiRslPKyZ1ECfXGmZ2yQ4TBVRqpV16oTy?=
 =?us-ascii?Q?LxLccWBGWMJryeM9f1vfBXP/jju/Q15UMU8btu3Fcae11nz+AlEzicRSWPn8?=
 =?us-ascii?Q?nqpJRINOjvOuPpq0QLHyF3IfrrtONLhqQ7MXvERytvwT5mCpAXl8I3gdFrj+?=
 =?us-ascii?Q?kqXvVn6KNxIdz2WbiGSQtGi0uQFFL7o15PKL9yKO3r7EPmrikbsvJDWbAAvG?=
 =?us-ascii?Q?w78UeJlnu7ZWTtl3gUDrXV0HCKPEheTcxKi2MAt8S/zWBl9c1WmjVREgnHSE?=
 =?us-ascii?Q?O30dlWtF9KXkwZq2rrFhHtMCv/koVjKjLC5xeHXfsUCcvGvqtT6x+XBozN33?=
 =?us-ascii?Q?lbikMBFmQzuVdAYf25OkNX1qVw5rz3f25AbT8Ebr6YevxeJ2H8rxVdYBdZUQ?=
 =?us-ascii?Q?s0JYoHO2XvItHUqR4Nza932+jUVLCkKYbtC7mGhaMEd6y7RsFDPqvQf1T78R?=
 =?us-ascii?Q?IKVSkEfgh4GbQ1p4TLiH23jqaDIVjqRGY6KKIMQ0W9x9VfewBRUQv69+dQbX?=
 =?us-ascii?Q?lJHWR6OMrOFCiDUtQ7sd87bcb/2uLqMpA8P26YDNJT9nj/x+ukhJ1DMf4XZZ?=
 =?us-ascii?Q?vP0YsuXEgsYGPNU+iKgLZspwXUc0mJAPZQIvIZ+pmL9XorLHEjw6f2zdfd3p?=
 =?us-ascii?Q?/3LpPlaLdLDLT2rA0hNF8aVkScp5idk+x4cegXHHvF9Gw0YYndgvQDgxP2w7?=
 =?us-ascii?Q?t8A9G2PC7aTvp71avwTB+YnFP0PU4hHJ0SO5CxfG2aq1mkfI8VwVCQVAMjWs?=
 =?us-ascii?Q?PDpay+yD/ua5uTU5Sp0JBZZ68oqJ6MspEsHTDpUrV6Kwi7JRwz/DqpOVVJNz?=
 =?us-ascii?Q?0jHc2wJDC3OYf4JSszwr559ZkwSCHZkurSSa4lFmlJDAtPQ1T2WrQtAHm4ea?=
 =?us-ascii?Q?qs14C8MXI1GRYRqWpBWmST/jamawsD780n1MDE7QpNGnGVGcUQ9WERJ+Se2G?=
 =?us-ascii?Q?l0T41uGZOMSNcbCJ6gLu/YhVCboypjYilzHabjQY6+yoM0wST8luPsBtlNHM?=
 =?us-ascii?Q?E9RG/3AID6NR3LuzDqt6NUoeNtHvxjUvYleAvtxwQgwxiMNOsfzqqUFNwqGg?=
 =?us-ascii?Q?EtT1IsSroS5tG9SW5h0vnyFtiE4x7speXI0IKgLNVNl+wFLrYzu6gkUUKHwc?=
 =?us-ascii?Q?rXVEb9UEpIenJ8ccBrJdNsVbfRAolTM641iA7D6VDDVNL5B8HiZj3lwfiz6+?=
 =?us-ascii?Q?I5aHMkvtqh0J7wXc3wxRZYZMkmwGkHpIMeMBzByQY0lVKWf1ETaiCzG6YkcA?=
 =?us-ascii?Q?Kbp8+ge+V2w01p+m06kjbx7da1Rxi2M4EPhxq4ugt1ZAaljuSM9scYbqNY06?=
 =?us-ascii?Q?1xKscE9diW3AvQ6fU0qMgq18NKhbD/9T1KVbCvwsN3NwigIvHLYSrPffYpPR?=
 =?us-ascii?Q?QrGD0pSYxdREZZiEEKw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2e3b47-2f35-4245-71ee-08db734cffa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 18:17:54.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vE2pvTTblkYHdgbK3D6xGRtsyJrojENTG0KDrdnas6JXZKaXJUT8Xiu88StkhmhTvm5oDTHpbezX8nYiXer5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Thursday, June 22, 2023 2:12 PM

[..]

> > > > The proposal for 1.4 is literally very simple as below.
> > > > 1. All existing fields of cfg space stays in cfg space 2. Any new
> > > > capabilities to be queried, query using a vq (aq, cfgvq, whatevervq=
).
> > > > 3. Optionally existing fields can be queries over vq of #2 Once
> > > > this arrive, no need for new GET commands.
> > > > Till that time, don't keep infinitely grow the cfg space.
> > > > Any next addition to cfg space, should work on defining the cfgvq.
> > >
> > > Simple, but short sighted. I know you guys don't support your
> > > hardware for 10-
> > > 20 years but for software people do.
> > > And so "All existing fields of cfg space stays in cfg space" is a
> > > bad idea simply because this does not allow removing things from
> > > config space not in 10 not in
> > > 20 years not ever.
> > >
> > #1 is for backward compat for existing drivers.
> >  You missed about #3. Existing cfg space fields can be queries using th=
e cfgvq
> too.
>=20
> Then #1 does not matter. We can give devices choice.
>=20
> > >
> > > Instead we need to allow two ways to access config space.  Teach
> > > drivers about both, actually mandate supporting both.  And then
> > > devices will make their own cost/benefit decision about which feature=
s they
> want to support in MMIO.
> >
> > If both method is mandated, I don't see benefit at all of two methods.
>=20
> Mandated for driver.
> Benefit is for devices, they will have the choice which drivers to suppor=
t. In 10-
> 20 years all drivers support cfg command and then people can start shippi=
ng
> devices without MMIO access to any registers.
>
Until that point devices are forced to burn memory, which is not needed at =
all in < 3 years.
Once cfgvq is present for new fields, from the day 1, device does not need =
to store any newly defined fields on MMIO.

And 10 to 20 years, it can stop for existing fields..

The clear benefit is fields defined in 1.4 no longer needs to be stored sta=
rting from 2023-24.
=20
> > VQ is generic part of the spec for slow and fast operation, so it is no=
t at all a
> cost for config reading.
>=20
> This will depend. E.g. if there's a single command to get all of config i=
n one go,
> then it actually can be a speedup, reducing the # of VM exits.

Yes, one command to get all at least device specific config.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

