Return-Path: <virtio-dev-return-11300-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AAFC6FA8E
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:02:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6FACA2A827
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:02:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A027986603
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:02:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5EFF49863FE; Mon, 27 Feb 2023 03:02:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BCC09863DD;
	Mon, 27 Feb 2023 03:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPBc6YcJYMNgO+qLHR93HzBwd+FL7qMEFgVvBA/2dN88hVGfPOlIJoFuRKgb45Hv3UIwrlhMhB++229hxMrQCJUx4hI5HgsbdpmP8lrgtf4kH0GAz3BynLbcUYfq3f4ObZfkfj0iBDwkeRARMdw4sXek1J6AQ8Wc2EBf1W5ny9xv6rFaGTM/KnZvtDvNuXJyn7z/X9Iv2uoZATxnoLEW0T426FRn5sDkX2jj0f9s7pHHOR2Vogj1LUyzXokmkgTh8EnfP7pbqxx7WwbH0Z8iDCbvYWMGTkPkpaF5+COCe21P2+mWNfQf8JOhx0RrLeR4sD0kPGQ+48zhlYtsB7jotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2RCLQTLgxU2EpD4rxI3V1uuNVwn7Edwa8opVcjL2Hg=;
 b=lA/gdwIbe1kLSQv04+TEis0ePq2KAKwAGhLpf2F3aa1HKv+B0WBDBclRp3FV5zy2TX7PQFBUJsuhKMsDsGO6g4aXF2+df+op+krLVdqt7p6ieywmIdutVvGizc6Nv4i0HZ1bdPigerWZ3W3aBEPRAg4NKho4WjiGr3afChdCTjOfz6P0BpLrFvGYJLW2MS07bwPr5JQm4xDszW9saSsJXWafJfa59QFHx6pgq748bpS84Bl96HH1YNy6NX7SWNsMeUhS62rMVEiPeND6yYo12eslkfdVnajSsbSWUPlwhvC2AcQYwpJF7nsx4aF1xq63+bOpf8DAJGf2NcAj7q+kVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 1/3] transport-pci: Improve PCI legacy device layout
 description
Thread-Index: AQHZSWjEIPFmNZhzs0+igQhMYO1WBa7gSWSAgAHRxpA=
Date: Mon, 27 Feb 2023 03:02:10 +0000
Message-ID: <PH0PR12MB54817FED59372B4F965B473FDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-2-parav@nvidia.com>
 <20230225180014-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225180014-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB8093:EE_
x-ms-office365-filtering-correlation-id: 5f956357-33ea-4bf8-f7cf-08db186f04de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n2+B2+n0jxuMfapyVSwTspJPCEPZ3Yu9LXcFD6VFV66xauwORh3xmAHQlJ1T2I8L61uY6MbdQjVcaTx6wVl7rjxkqeJi49c7oYEfUKu9DvhZyTWOaYLPlaUsT16k7iOkrTImiy4m5uN7ui+tEF1ZcSUljhzXxqILIA4Fz6CjZQg8kVPiZvj+t8SOMCZMzY5bvW/3pcdWO4XYu5oqaf+p6zS4tAm1WtXbAvwnlbRsgm0gB+E2VNuW9JM3bCbYu+cinDvHwvM6/rkE62r8qOrG7i5r0dIrAxlQAD08YTNQdZ1HBiuyQwQ05Q5iA9d1wok7SvMyVHBR8uSjRac1BJpZSjwkp6fv+JPjFMZ09CyXO+gRr/puvoAvFGuCLXWKCdsJWv45px0ScL7U/njQiFAYRQMhRiBXx+pj8AR0mwsY/++N1gomplEajil4khlaBqjf2BqWDjeViPXAwWnQ9bfkGc0x/SaXShaHbH1IflsSKXp55PF33VxuvRyMOfCHwfndIlkhlVB85x3vIZNVGt8FyMglX0E/lyvWqon7O3NWFXpSiRVe/fRs0CmSMZ8vGC03ZbJ9pmjhaOcn+lbRevP5R5wWTRN5fo38EpOSKoserQ2Nv+7FuHiAro2yFPlYdpdGO3fbRFZtF58ddLOvn0640d8UMKkiviletDtdi9KbFuPm2RZOC5ouFdyrtVlxvFEmtZaDGAxwYa/rmhpiICpnPg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(38070700005)(122000001)(86362001)(55016003)(33656002)(38100700002)(5660300002)(478600001)(71200400001)(2906002)(7696005)(54906003)(8936002)(316002)(52536014)(41300700001)(76116006)(66556008)(66946007)(9686003)(107886003)(26005)(64756008)(66446008)(8676002)(186003)(6506007)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IVq1WPDkDRLmS1SxV0qYvNhMPT3e4fedZWBESWUObWWTt7WqFisHFLJQgTME?=
 =?us-ascii?Q?W3sIxWn4DxS9v3sfK5LkvyCvz3E1huBZ8okkgM6+xt7LYlGtphyhxveHjVlc?=
 =?us-ascii?Q?l38uugmGWPykix8vVbGoSKhPg8uy1QCmC4tmtNoIBSYkrUjQgx8zteqis9HZ?=
 =?us-ascii?Q?h+htq+AOrSQoupiSBBffajcumNI5qjfpYH+ErPLR46rDa3uiA9PkU9PGu6TG?=
 =?us-ascii?Q?Sgd1UoADWvJs3GXMp98Qbm4/wqj7jL8gyfM4q7LyTxDkjHad2H5YMgh6xt+I?=
 =?us-ascii?Q?fE0ifPMdtnZ1dxc2Yeu6PKWz3jPtYZzSk2kmujYSNY1ttMl3zKagitZVcT53?=
 =?us-ascii?Q?A5MlhrSFeXoc+wZ7S6JSv698rHWHxSrMG20N6A8UScDPsJc3YqkjGBJ/nJHp?=
 =?us-ascii?Q?g5xHaKpwf1SZl/iVteuU7XNug0cw5DPbQMX5/ai2F+Xh5D3nx1ZuhCRyX/G9?=
 =?us-ascii?Q?z/tuNJwNFiFkWzHUy7wG3WlKZy6dlNGSWSwWnGYXn3oakq+a6fMIYJaS8hIC?=
 =?us-ascii?Q?OjfkaJr8XcG+KUao2178W5GZs3lmBUN5rbEvjzNw1YmmzFkBQbBTtDRVWWHP?=
 =?us-ascii?Q?r6l50aG6GZGzczYBAgyn2puk5v6wTSTG5W6WylYDe22sXjZUN90wlfQUNVTU?=
 =?us-ascii?Q?b4qMdFrsLLNnrQkRwKeknBCsd/Mo0P5kyjcamB1cdpQjVzJp7Mnldl2+r3wq?=
 =?us-ascii?Q?kHGTwXZBBGjccALEbn//t3A0Sfact5GdPqh11SEG/LwFMMfobco01JtbgZjH?=
 =?us-ascii?Q?yAB9JRxZ1RD9SNXuriNBrerDhJfLEy5K+ILx3pvKM9Dl5HMfjilES+Ov5i1G?=
 =?us-ascii?Q?6XA/f9aYPsLbGiEO3d2MtaqZ+qRk6+2oHTTmQazDRQK4VqyhdKxyS/NTnXNY?=
 =?us-ascii?Q?7kETEai1d35aNE/hvgJfe8A1FoiMPEKq8LaDyh9nrS8xH6zpCzRJLmSUcf88?=
 =?us-ascii?Q?iXFi1u+lXhK/Tzbpt63MHDdld54CgDlhPp2beM8EZVAedZinqXfl+Ilkx1CC?=
 =?us-ascii?Q?WPwDHak2XKPFLmYHX3riuSXKNz8ZAtsEytRlXdL9gRi4R0c05AOvKv7bEukl?=
 =?us-ascii?Q?n2GaGNvl2HM8WOVQw9oxan6NKabwWnzL7Qy8wLP9D7l60hBoy8v/2k4pf00s?=
 =?us-ascii?Q?J7LkFuTLScxFw3Dcu8b3O3odfSNAoYbMCsrW99BSDail7AKJYfi1Uwz+SPCh?=
 =?us-ascii?Q?muFoU6s7CZSNU8cF4BtEvVTK4a4MevMN3weHJvve/Qku8CLnneHja3AGaFo+?=
 =?us-ascii?Q?zI0372XWgxnpstHNevMVzKww6eQ2xvs3wjmppSNiXiW9RAAWu/IaRrrSFMtS?=
 =?us-ascii?Q?jzzxG2ND448bTtKcwVaYiM+Y7i66PmC1ySEQDtrvxObOceXqGm6JYYQKlhGM?=
 =?us-ascii?Q?2x0fUAjbd5p7oXIki6dlYCo7zQFtbcwgP6ivgLDNPOzNQQz04DLWXnufijIm?=
 =?us-ascii?Q?XisXYv6vxJDd/05TsL/vO/S3+tcEzgFliIOTFsXY8Sw0PcV/whcckosqQmWw?=
 =?us-ascii?Q?txUGgFfKUUpc91Toib8bkJ5Jx8StMMwwCvQzCV/JyJjsyyVJOY/VxVrck44E?=
 =?us-ascii?Q?1Lsh5kcrpsfD+enEPt0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f956357-33ea-4bf8-f7cf-08db186f04de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 03:02:10.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Zx8oM+l840aGhvksyB29ZuP+B1EFpuqc0GGsfCyyX5abNJEdKqMNXcoI7QoTwSxpDmXPDoHlA4gFm8hvDNpZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
Subject: [virtio-dev] RE: [PATCH 1/3] transport-pci: Improve PCI legacy device layout
 description
Message-ID: <20230227030210.rks9U8uKkYYpxpaQWDVMXBTDj4LJ6WbbwVhDGWoBVss@z>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 6:09 PM
> On Sun, Feb 26, 2023 at 12:29:59AM +0200, Parav Pandit wrote:
> > Legacy interface PCI Device layout description has following issues.
> >
> > 1. repeated 'structure' word
> > 2. virtio header was defined the 0.9.5 spec. In a legacy interface
> >    section it is referred with different keywards
> >    as (a) virtio header, (b) general headers, (c) legacy configuration
> >    structure, (d) virtio common configuration structure and
> >    (e) other fields.
> > 3. Driver and device requirements listing is intermixed.
> > 4. spelling error of structure
> >
> > Hence, rewrite the description to eliminate above issues as below.
> >
> > 1. Removed repeated structure word
> > 2. Fix spelling of structure
> > 3. Place all device requirements toegether 3. Define legacy
> > configuration structure that consist of
> >    a. legacy common configuration structure and
> >    b. device specific configuration structure 4. Rewrite section
> > around above changes
> >
> > This is only an editorial change.
>=20
> No, editorial changes are things like spelling corrections.
>=20
Got it. Will drop this remark.

> I have trouble reviewing
> because I have no idea why you are making each change.
>=20
After documenting legacy interface in the spec, we cannot claim that driver=
 is the source =3D specification.
Currently transitional device and pci device do not scale well (or doesn't =
scale at all).
We are working on supporting it and having better defined transitional devi=
ce seems important part of it.

> E.g. you just rewrote a bunch of text and I frankly don't know why. For e=
xample:
>=20
> 	-When using the legacy interface, transitional drivers
> 	-MUST use the legacy configuration structure in BAR0 in the first
> 	-I/O region of the PCI device, as documented below.
>=20
> is now apparently:
>=20
> 	+When used through the legacy interface, the legacy common
> 	+configuration structure has the following layout:
>=20
> and this is better? why? we are replacing a clear requirement which appli=
ed to

Because as I explained in the commit log, that one structure is named using=
 5 different names.

> drivers with a vague statement which I can't say what it applies to.
>=20
> Any chance of splitting these things up? Maybe that will help.
>=20
That's a good idea. Yes. I will split these patches to smaller one.

> Apropos I don't know that we want to spend much time on legacy sections.
Transitional devices are very much in use and documenting them well is impo=
rtant to build scalable transitional devices.

> Really with legacy code is the main source of documentation - if drivers =
work
> then you are golden. If they don't appealing to spec will not help.

Yes, so don't want to add additional text. Just correcting the current one.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

