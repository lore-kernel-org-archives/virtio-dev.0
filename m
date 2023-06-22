Return-Path: <virtio-dev-return-13055-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F29EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:51:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 75A8BD41E1
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:51:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EB819866DC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:51:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 62E9C9865EC; Thu, 22 Jun 2023 17:51:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DDC29865D4;
	Thu, 22 Jun 2023 17:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8blhopPjgHD6HXQ7ZoWqZuqLcMpUq2+CPb3qhp8BvJBt0CH7AGge6Fs1kq18ErL/zeipmT5NXgmV65MVcV1/swOaigegdl3yu5iiuQBYnUvpGmSi2ZZKl1uLP0vhzikPFRhaQHaSCmmK2Q7ohKsFQhB5Tmb7fXiQ+J+WxU7myyn+9iHmhapwfk42XCAylc3mtmynqNK0L0VMOh4qp46ifQyF6erBasDgO5fUg5pL2XownYaO9JwHT1tp1rTzTTiJGFX8769gtiVdLnUGP357l7agfj0LZwqm1BQMFDyIpPiTMo0Vqlk+L8EkaZ9M3Umk9MjvBbL39IzVxezlTW4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4cKUmvGYI1xFdm0hl+sY7fWwIXV19AOH0sb4cPRqOw=;
 b=npZR0QFrY6rYxkVByfbr8zkskhg+QMpEVaHq+1CpRo27ULRkgfQQQ7UZ47UO38qCGPt5gyt4kKq/pQSEXykgG7K2u78bu0evBta0Sy/ZQzHgce8VSWzO3QV7QJWh1pfnYBgdPtwLirS41QRmExxA0v2LlGHaqTsz2Pilju4U7I15Npho2aWDFAyGtm3NQQ8AlOx5aUaaBrr8JHAj8IUSIRrlWMwqBqgP4WFfmCz1JbBdq0GHtxAEZVtNqcQtoUqeAQol1fNy8udS/1KfZtRrzzVhwXUmGRKyNzXFt6rk/OtXAdjvRBPdO6SaumLaBxCeBdw/abyDwFLRr17cbrZtsA==
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
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABRroCAAAA20IAABzoAgAACfmA=
Date: Thu, 22 Jun 2023 17:51:41 +0000
Message-ID:
 <PH0PR12MB5481B65F624B16200B91B0AADC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622132837-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622132837-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8694:EE_
x-ms-office365-filtering-correlation-id: cc35e161-9d91-4c52-6588-08db7349561c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1chZwoGMNKTEUTeA5waXNz2QBzOX5904a7TAEAMP8Ht6TKjAoiAV/nQ+xONXqghJJtgGevKtB8NAnxTaOqzMraFQ1kzrm6SX8joz9RRhoi1OeCRGuuluZdzEL9Y+icOFdshNWGMBc3TW+bedTyiGYjKDUotRF6EtR4lYVBCVirwLTkwYEbYRnrxOOZl3f1T+sV80dXyOJYQfHQHN7l5xvZNEyw1gQEkgqNrtYANHP0KKeg7I+jPl0mIY7A4HL1UkQ5eYdoJjvO5v4Zpp6qIyiR77p/v2QYAQHGIz6k736yQfK5aqu2fmJJmlaqa6Xnh3LV5aYzaGkjuzjQIiAlVgg3f8IjCdzakRnKv/QnvdhIPxTtBrA/HaYa0B7sQbES61vdoYm4po4cuAlk+m/gUJn5kpu++dzz2PD3IT1U36pwRqs3p8eBgoAQFIOYHTXavskFmsaHRZxqlQtSTHBNcYhNw8S3FRIZDjK/EWM7DsPzIpyJ9ltfMAutJpKwn7Up5PAhO7Tsl8N6CF96ufSpDlTVZ1jHNjYgApiCs67dHz2qcvZvRVoUNMqtC5hfGPQe+hlocsupFO+fRgA9c+LdAk0uFg446xEHQu38xzE6Bjc1Q3MgUGykk/Mvs7HvSRCwaO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(55016003)(316002)(9686003)(83380400001)(6916009)(4326008)(66446008)(86362001)(33656002)(52536014)(5660300002)(71200400001)(478600001)(7696005)(66476007)(8936002)(8676002)(41300700001)(2906002)(38070700005)(122000001)(66556008)(38100700002)(26005)(6506007)(54906003)(186003)(76116006)(64756008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tg4/Pte398ipjknL1dHg9nJW+jL/itt8YWgP+dMzoE0AI4yKfYRCcCWD3GRr?=
 =?us-ascii?Q?C5FU2lkLXACmXo8C2AQddsrWoQeI512dFuTyNhifyOV0akc1XPauKhqeJkAN?=
 =?us-ascii?Q?FUEv0ZnbCSHp3ncwVfuzarkyIoD84rsdDiL1R7Ow+Jjra3tu72ggzF2lb9TH?=
 =?us-ascii?Q?P9FJ16Kri2c4lEf+M7Dnrn6siQp0iyGx27ghKsBFewFy6mlNccWo8EZqRiVh?=
 =?us-ascii?Q?FMBM6HW/VDf6cEo3bX3Af6XPbBAwN6RV0u1ZL3lfYIH8h0RZNnIoVrWlFPzS?=
 =?us-ascii?Q?T4cbVuipfol5KACkvoNvmYZ+7m9soIN8CfvMX+xk3ji9r5it3D6ERD9W8KXR?=
 =?us-ascii?Q?8/0icvKQ7/EYtoaQ1igaStKyUQe6VsccVJ7RJpu5bZpvlP15prC//1BD0di4?=
 =?us-ascii?Q?lRAR+FqJ+A3YjLdIQs9eqcZCTbxQThMyw97fGSijIvB0pnW9H0fdaGc3C1KH?=
 =?us-ascii?Q?R1F8q503TmRiMla4s9oYJ6drKnvdLdFkDXwLBaYIsHjsajpL31DLLrSRk7H5?=
 =?us-ascii?Q?PLiWa436ss1/UT9cH+x8FG97nQIcUbqJUy/pW6QqqYeCXyXfqxmFJJM4wONU?=
 =?us-ascii?Q?NeUyA3WHkkVc8F9QUYR/tpmbWwDpoy7294a+npoFJD87c2HDM2EjG9HgPHL4?=
 =?us-ascii?Q?ZsEq+clLG4wwCOrwSbiB/5ZJxa+pO53mtnbHQ26GJGDTCyaArinJ5y4nel69?=
 =?us-ascii?Q?76l70i/9krI1eIF1JXwlqo1qBaRGBT6eZpAn6689tj1FdCm0IX8nsrPVo0jw?=
 =?us-ascii?Q?ergtsHny6HOsqPcUHiFc2RTd7n20gwhv6k3kUZeFNIyYxRA1Scl3XVxFN1mk?=
 =?us-ascii?Q?Ai32b9HaaTKxsYhF+n9C0zF41QlrrzJBZk/ISs0LS7bS3Vk+TVk/zY0NhaoW?=
 =?us-ascii?Q?eTADRv5ronG6B52rl+gP8Jqx8segjpqOCBkNJiKNcbEw9VMoAUyc9pDXooWT?=
 =?us-ascii?Q?CqeBKbcb3zudbVOyYmnFjTtoGI1KEVngNBVdBsJY91emVnT72O9R/0ujkbog?=
 =?us-ascii?Q?I8KPq6TxDtFzSdZIGaQN0h241vv2kd/+TmCOLUeGcBKYCPRuwIpLLJpgaEeX?=
 =?us-ascii?Q?TCyQmU108Oa7WQygmhrKONJi/FQBdTyjWSgfnCPxlOMHdduBmyKtwo7vCQSb?=
 =?us-ascii?Q?4ZSiA2ps+FIQSwXpNy6C6EjmMKCqfegKz09yQZ04OoDR7MpR0OVLncuSx4kT?=
 =?us-ascii?Q?P8DL3s038OrcGntGYGosYw0WdI5qhAIVy0pOFDjeInHkbb6JBTlBGg3aw3M3?=
 =?us-ascii?Q?/3/CFWgopbRzBRavQEnAr3sm/A4v98H5FqsUXtTWewGJHaHZ6CK4odLbWw3f?=
 =?us-ascii?Q?dBICzyOrwKO2hIX5TpMxh+nfTMlh/uyL6ytjwD/v9EcKk4kd80MaDChwdCod?=
 =?us-ascii?Q?LEwLJN3MX+iYnyjvf5kHOgcZDD+wVtQz6ZvGiZUDKha6ad3/4kMdVI8hFyRK?=
 =?us-ascii?Q?EYq73HX8aUmxkBxX+m0NGzz0AvMs9qnQX/E71pZwLiC/hE8Td54PN+ntxZfd?=
 =?us-ascii?Q?EPcp2rNcy2SDLTi0N48mWlsKenjIYo2P7zFAP3vP6qxg5fiCd+Sry7us6RvD?=
 =?us-ascii?Q?HMSEywDS2CvMThBFLbA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc35e161-9d91-4c52-6588-08db7349561c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:51:41.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcjbuobk2wzf6Bx0DhWhP/RQWOH8OMyAjvCzBUHUs/BmuoEXu7GnXINHy++URHAwE2fhhHjVwhC6T1NmvLpBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash


> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Thursday, June 22, 2023 1:38 PM
>=20
> On Thu, Jun 22, 2023 at 05:15:50PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, June 22, 2023 1:11 PM
> >
> > > > Provisioning driver usually do not attach to the member device dire=
ctly.
> > > > This requires device reset, followed by reaching _DRIVER stage,
> > > > querying
> > > features etc and config area.
> > > > And unbinding it and second reset by member driver. Ugh.
> > > > Provisioning driver also needs to get the state or capabilities
> > > > even when
> > > member driver is already attached.
> > > > So config space is not much a gain either.
> > >
> > > Actually it's RO so you *can* read it without any issues:
> >
> > It is RO but not same across all devices.
>=20
> If you provision VFs differently. I got it.
>=20
> > > - block guest access to status
> > > - check DRIVER.
> > > If set:
> > > 	- read features, config
> > > If not set:
> > > 	- read features, config
> > > 	- reset
> > >
> > This is what I explained.
> > It is more messy if you equate to GET command has mess.
>=20
> At least it works.
>
And new GET command also works when CVQ is trapped.
And also works when AQ is querying capabilities of a member device using WI=
P cmd.
=20
> > > I am not saying it is elegant but then all of vdpa pile of hacks is n=
ot elegant.
> > >
> > I don't want to comment for vdpa. But it is not part of the spec...
>=20
> Neither is QEMU.  It's one of spec implementations. Yes, we care about no=
t
> adding blockers for features that, superficially, might make sense for th=
em.
>=20
> > > And I am all for building something better but we didn't build it yet=
.
> >
> > The proposal for 1.4 is literally very simple as below.
> > 1. All existing fields of cfg space stays in cfg space 2. Any new
> > capabilities to be queried, query using a vq (aq, cfgvq, whatevervq).
> > 3. Optionally existing fields can be queries over vq of #2 Once this
> > arrive, no need for new GET commands.
> > Till that time, don't keep infinitely grow the cfg space.
> > Any next addition to cfg space, should work on defining the cfgvq.
>=20
> Simple, but short sighted. I know you guys don't support your hardware fo=
r 10-
> 20 years but for software people do.
> And so "All existing fields of cfg space stays in cfg space" is a bad ide=
a simply
> because this does not allow removing things from config space not in 10 n=
ot in
> 20 years not ever.
>
#1 is for backward compat for existing drivers.
 You missed about #3. Existing cfg space fields can be queries using the cf=
gvq too.

>=20
> Instead we need to allow two ways to access config space.  Teach drivers =
about
> both, actually mandate supporting both.  And then devices will make their=
 own
> cost/benefit decision about which features they want to support in MMIO.

If both method is mandated, I don't see benefit at all of two methods.
VQ is generic part of the spec for slow and fast operation, so it is not at=
 all a cost for config reading.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

