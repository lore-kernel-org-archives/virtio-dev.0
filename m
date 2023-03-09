Return-Path: <virtio-dev-return-11588-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C46C61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 20:08:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CAF0A42A6C
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 20:08:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAD7598671F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 20:08:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ADA3F986708; Thu,  9 Mar 2023 20:08:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90839986704;
	Thu,  9 Mar 2023 20:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af9pyt8HkVCxLfd07XdIwlwDlcJIwcDuqRU43EsP5CuA4uPZGUCHpCojEAvU2DubpQM/jd/DXZr2zOjnPxb3DwZ7UjozcTfrLcZYsSU16pKGHCABNOduqNsOrDfy3TEPIj3dyCjFC2hXaY/VxZIDD60brve85Cp9S1LOVc31DaHW9B5YG+Jz8AIIfDpl1BaLXLUoV7x4g0hOJ+Cp2OnIjn1n2PH6SyPX6hxpzx4RgAziMpwK2u6pJInlnqIhXsXGdg/U1AxLFWP1k8F2BnHeI+cF97zn8ztcx+1GeAhe9EdNL0hXTw4iUMMzj2vrR3hSnvx9QnYccdEgtCf69ppkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuwEYUSEBbm/TW4GKkxr60QrKZzfrRfv1PxdQ7znCpU=;
 b=dbdzE/li3pJElGo2h5GU/ktSYniPXVtzB1xyOQqBFUZDKSGOqvZ6SXW81uv0sVcknHTPeff0zotC0zYeEVitDf+QzOcN1XCQFArKINcPsRoljp7FyS5oWWOC3czp5a6oXIxCl9KDGM3ri3bW1YA+akBhK093scI9L1t75N2ssLIVxjzgQ0K+zWieGfd/hGAeWlS2784Xq8Ik1xJmqYod2/moyL0O1GFPRzWcHkvONfMPkdmZTsWUSjItdsKRPDuIrDvpUZGLWbfO1NNbd0OiRqIrcwEG2VkY04UH9BeJ9jYP1gXwRNLDpGUGnvAOhQme74zgGIDci4eKop5w10EVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Alvaro Karsz
	<alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v11] virtio-net: support the virtqueue coalescing
 moderation
Thread-Index: AQHZUofRGNH/4WaD+0OGDLrUgHL6J67yy9mAgAAHEoCAAAIkgA==
Date: Thu, 9 Mar 2023 20:08:37 +0000
Message-ID:
 <PH0PR12MB54813A3D192DAE134B002E91DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230309130521.109102-1-hengqi@linux.alibaba.com>
 <8734c0de-b041-a4ba-9f48-44dc4ceeb513@nvidia.com>
 <20230309140313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230309140313-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7978:EE_
x-ms-office365-filtering-correlation-id: ed4696ba-d65c-4230-a1e0-08db20da117e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7Wr8ksLcwxDUdRF56Hv7BdYZtxDGZw6Gstp5vrN3Src8t4mmNr9Vi7xMWT8aPr9/J99MRXqdsvPx/e8h8BTG5DOaiQ4m/yPlXKbTsnhYeXMZ8chjE9/2xAqNKKpe8SGZadOuUN32NHAE7uulhpzmfu+itH9OiH3LQbz4dPjIShjIo7cofQLTf7wpb0/vB29AkI3kiAR1mMrACog0JF/CGh556AJoVBUwRFNLbOeLr+AnZXh9bqhg/TKHB9u3jnI+eiLCWnwbkbJnH1GbRjcQGL3lNYz8d7vx922z+i8B6Mroqnazk9YiC288ZHRrJtKPzvh1qO5vqotYmlN9YZ285fVsCFeBLl8n75dc21AYiff2Bnavh2aDXzY1+5s+3X3an15FNbsc7K2sAgoaUlUvezZpGx6Nb6mUY2JN8diji7I6gc2tNEff8nWBnogHASbpDyJvj7VAwLCLaNtne5uMYnN1yYdmEBZoc6AxT+XHB9rPxv0PXk18stNltSWaLjrhIesHiwKZGwKN6CM0Z20EojB9LlnczLenhJagetupeiZHbg7DCnPeEkBuQsFqBeIcZbIlICA14z2A+u6jy32KFTxETAHzs6iJq091nkpw6xYl7lP8mTZp2fTErgmbShvwNplkAcz/kzXuslBZdZLgHz6aao75F+dIrAs2wsP/NpbjBKdsxF8mmA/NKRYGDvU7MSEROCkR1wVj1QInAkf0Gw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(33656002)(54906003)(478600001)(4326008)(5660300002)(7696005)(316002)(71200400001)(52536014)(8936002)(8676002)(2906002)(66476007)(66556008)(66446008)(76116006)(66946007)(64756008)(41300700001)(6916009)(6506007)(38070700005)(55016003)(38100700002)(9686003)(86362001)(186003)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E56hHHOcbFUIUpyzzhcfagy2xZxhzwq8BJ7oqTmhy5NJ0H9ex1XrktFLdcS4?=
 =?us-ascii?Q?Lg8ENxkLUWDb00Roc5HxqFQMSm/J40KiGhltYH+olbnnH+xRmY71Cw+wrJ8d?=
 =?us-ascii?Q?hzMf8hpokthJr4S/l22RfrGPKlyWGsnvTRXv9rRV/Yj+6JR+zA4cHQeyoUOM?=
 =?us-ascii?Q?dLeBI8wXWLQT3NyYLEAHujOzbS9xAjRl+EXn+t5ok7GUOtBdA7rlm64uO2Lt?=
 =?us-ascii?Q?ntXkOOHTq6xAh8YDIci7wMDf4JmLD8NsOaHgIMGXMCa6dmvudbVVzL9X1NFP?=
 =?us-ascii?Q?tMnVM/0EqbZsiGOKDuWCWNJTNtPLgBCV2wlR0qgzvihnq/GR2ormkYU2Ls/B?=
 =?us-ascii?Q?DCpQwlxcByAE7Kxj4fWtL6YB+M7e7JX/BYnYtYpR9vKPxs/8xD5Ak+Qvf+wL?=
 =?us-ascii?Q?O1SJ6po06v2tcPLgo9IXNStGRWmkpz7uJhXtUZRWURG89B8eDZn5TYqHSC3b?=
 =?us-ascii?Q?U8z6tFA/n9i9WlzAijndqE2+QdPH72nMNhwAsgY3mtDexWLjQo9EbWWfwDxg?=
 =?us-ascii?Q?lo+NXPaQLtgw0JNZl46/LXlT9vuuNFolj8j/nsfoJgWM0KGkGWHEg6NNGv+E?=
 =?us-ascii?Q?+LAOnrOrofavr9dr+8NSY6lOB1qiaL/LH44Srw5ycwyEZ37QzCHpXsMREV2l?=
 =?us-ascii?Q?RWHNgsqSn5OM+cL0MGCC0a2kChy+9ZM53Fv5k4xWKX8WPWpFQDP3vj+fPVpd?=
 =?us-ascii?Q?Ok+3DyFU6P1Yyvf7eXIa4mRN9U1qoPzm289kq8loGOSqYyIcg3sx8xlVplbq?=
 =?us-ascii?Q?LY5LOls39AghUwDdzlKZ7XAbtT0SKGLQXNnFJ9CUEVaPTHm63YndQ2PAcfyJ?=
 =?us-ascii?Q?oQVnyKs6ZE99kMEqJYnZbBwOTanRSWPXEukNmuGX+HJLR69PynAEICKsLDuy?=
 =?us-ascii?Q?PIuQLS/ZXtZp+vC2+X6j1iY8TegbS5FyQBDUbVlIYtw4Pj5cVONK+hd72EpN?=
 =?us-ascii?Q?764tZTHGbcR5+lQdVFfvWIwbSsndyPpwazym5rymyw08IxITtHth0H7FwmCv?=
 =?us-ascii?Q?mON2qwDsygW+uFYPO82zsUrFxRQVJVmjlOmY7CwRcqlyaeQR5rnkvdNJIoQ9?=
 =?us-ascii?Q?V8iXteRt3lW2kKqNnekT61FduML57DAehPN0Xfgckr7Zdx7tHCnjjvsaCbZ0?=
 =?us-ascii?Q?pH4V40Qh2MS6hdz1I2U0e9rR9Er3u2552kwjyfjq+fm5PUy5KHmTjabrVpZm?=
 =?us-ascii?Q?f0sz3ScEv9ufk1xhpiAt14w+wNqn37bKe7ynEqS9VfihNE58jhIRK6llQ7G1?=
 =?us-ascii?Q?YNhOsz14dPtSxKb8ifLyDdC2Rsy64Hm6i9arAAEaM2kKlmeenW4e/yeQSFcw?=
 =?us-ascii?Q?yFv9WbUeqHVnvtmhwZIk8L9p18MgmoDZ+cg8MJ7R1QPLuzXSfrnsvLFvpB3H?=
 =?us-ascii?Q?YcXGJcLAGhjAZS3ySSCI8j2ANf5E9onecQgldz6Z8Jxkb1QynghyZEoMb9jd?=
 =?us-ascii?Q?Mp5SiV05YC8oKa/cTorKOO2rWAOej2lQJ6ghX74u6exHoeh2O70tJuKw5/yW?=
 =?us-ascii?Q?bFMZtaB8svIEW3FHT0zkdTMXWKIGl+2pGBD08b52RjSSMTrDbA3c9TsclxLS?=
 =?us-ascii?Q?QA7RHtHxtr2/VsvFL5PwJMgZ5n0DEBMzNwJkwwTp7pJf2kurPVenMgnKEHs8?=
 =?us-ascii?Q?LrK4R6GpJpfJi37Up9AysD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4696ba-d65c-4230-a1e0-08db20da117e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 20:08:37.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBu5AHSDDCX6SxZ4HT0XcQFZywF/giZ/y17Qx4orpMZ+3f3L0BPni6f2Gp6I8l/yxmNRNEerkkqORUpLuib+wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
Subject: [virtio-dev] RE: [PATCH v11] virtio-net: support the virtqueue coalescing
 moderation


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 9, 2023 2:19 PM
>=20
> On Thu, Mar 09, 2023 at 01:53:37PM -0500, Parav Pandit wrote:
> >
> > > Network Device / Device Operation / Control Virtqueue /
> > > Notifications Coalescing} -If the VIRTIO_NET_F_NOTF_COAL feature is
> negotiated, the driver can -send control commands for dynamically changin=
g
> the coalescing parameters.
> > > +If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, a driver can
> > > +send
> > Above text had "the driver".
> > Better to not change it.
>=20
> I don't see why it matters. In most other cases we omit it.

The hunk that changes article from "the" to "a" doesn't belong to this patc=
h.

> > > +Upon disabling and re-enabling the transmit virtqueue, the device
> > > +will set the coalescing parameters of the virtqueue to those configu=
red
> through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or to 0 if the
> command did not set any TX coalescing parameters.
> > > +
> > s/if the command/if the driver/
>=20
> please don't just tell people what to do. provide reasoning.
>=20
Reason I think is:=20
The command is not the object or the actor.=20
The device and driver are the object or actor setting the parameters throug=
h the command.

> +command, or, if the command
> > s/if the command/if the driver/
> > > +did not configure TX/RX coalescing parameters, to 0.
> >
> > Also the sentence structure should be:
> > set params to value A configured using method1, else to params B if
> > not configured.
> >
> > Instead currently it is,
> > set params to value A using method1, else not configured to param B.
>=20
> I don't see anything wrong with the proposed structure, and the way you w=
ant it
> with if after else is IMHO weird and hard to read.
>=20
>=20
>=20
> > So to keep if-else pattern:
> >
> > the device MUST set coalescing parameters of the virtqueue to those
> > configured using the
> >
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_S
> ET
> > command, or to 0 if the driver did not configure TX/RX coalescing
> parameters.
> >
> > Just like how you wrote it in the non normative places. :)
> >
>=20
> maybe fix non-normative too. If  A then B is simple and clear.
> B if A is understandable but is harder to read.
>=20
Documenting one way is needed and without exact duplication at two places.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

