Return-Path: <virtio-dev-return-12978-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578C3EB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:35:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB81F120D4D
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:35:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DB1D986430
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:35:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 73C369863A6; Mon, 19 Jun 2023 17:35:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66BC79863A9;
	Mon, 19 Jun 2023 17:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE9Q+CKs0uyGj8xpDh+PWk3UVpEhdcOdJUhh0i3pbHLrvDc6rQBB9B98E2b0PGf8e2gd16Z6VI+20YEi+tHr3/b3mDS4LJh915X+Vn6/ZwPgYCRIy/QoyvthbytZ0f11GPnkqhztAqNJvBDHkfiI+MmiMi3QutV5M6GebNgRu5t92Z9V64GmMt8b8WnrDY73PYWUYS5SeUQSIWQWUAPor5f250+4LQRaoq5npc7+p+otuN9c1ycLAyjvvqOTbbcinieIXGwWIwbfx+v/z9aVRtrNm6+HiV88qqjSekNC+t/u8jxVe15mnIAaQgTmduICuVyr8Gc8slyCkHWC/FMQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpoBkfZW37r1pZ52MPDniRoxCPUBpemIIDx/b9T28rk=;
 b=abUvpqVpHOHzJzUzD2rgfhVBnP+/b8eTqjThBY/h/V15HEUetB6TCEMn22qT+WTUcCWq1LHCwaDI717N/8c3dTKf7XsxOe57mGY+iQ85gsMMLOFzL/gBihkkwRwXDWCaT7m+uJLzn3dhObQr7kMob+gdF4OVwlvFTX94lnqUfIXiVEf3Z6vSXRakqhiSozA/y6/kGAwm1b4wNABmvcXqyMAFARJ2N3TpxoCbz0PbJluyPLsjAnN0zgcYi8f2mHiiuzonud3WfSiJBrypRXKZq0CTtuXwcBtOsksIa067qeDond7p3trwrXWmgrNaeUUdNE/Hw4KaRX2VI5gztNroig==
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
Thread-Topic: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access
Thread-Index: AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SY/mAgAAAj+CAAAV7AIAAAUBg
Date: Mon, 19 Jun 2023 17:35:04 +0000
Message-ID:
 <PH0PR12MB5481D7DD7654CF3B18939956DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619124042-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619132018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619132018-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7595:EE_
x-ms-office365-filtering-correlation-id: e5d32bf4-de98-4e07-9c92-08db70eb8447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4WJKbkHG6paIjH3hxElM8/hIrcME2ELOd8rPgl21l41nA8lRedmYEDDTMcZSm9UBGNMFAWtS6WIZM6F5ZMQECRwxj03PZoCP2ALo5kRWSjMwkXW6TpO94KsTHCO956zinrvTvpUBzlcfLc1C92UrxkFXUILk4rjH9K+7QMLBgx6JhOChQxWJuvSAqpPiIULuX+uDRzv6BB/aWzeNv682Q/X1D02hRtB6eXAikkc62o5WJx5qZIo6IuFvyWGAjFD9Llqecfg5QqqMkPZFEpVkz9Zma3LzwBEy0kpqyY30zOYYxdmziZGTZRqJBkQzRztaN2t4Q+LF+1g8vJ5fwXTZ14epw3TFY2Whb+RqMkOtdj6UG2SCADnxzVC/h1aPbA1DbEVSUcMYRE1T7HlXOsnHxZeUjQ3+40MJBCvfH7EZAurQuV8oscAb29fMTn6/KviQZAHDsyRBg0Fb/ygrVa+snfOaEMlGusXFjS25k+IOdpakbc4ddS79q3xS0yYqCQRokdG0K7DIO8yfA2WV76BV6G3b2HstoDYORV4xSyUHa6orDSepcAlxrjQ6uAcz8VU2qGmuoNOZFhc+oGgaN6zopTxyye5fDBRgJ0fHDUei9P/wEwEc1mY+Mh8byTB7w3iF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(316002)(38100700002)(6916009)(2906002)(4326008)(86362001)(41300700001)(55016003)(5660300002)(8676002)(8936002)(52536014)(33656002)(38070700005)(83380400001)(64756008)(107886003)(54906003)(9686003)(7696005)(122000001)(478600001)(26005)(186003)(71200400001)(76116006)(66476007)(66446008)(6506007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lOOpq9gnC5aMIQuUKuL5Cec/tWDLeF45X9QMRAjQSS07ROAOuYwhMuMe33Hp?=
 =?us-ascii?Q?foH3hB8dmTPWP3xICDpRvbuMTGcDmXzxY3c1oq9p7Dnvmzqxrxdf+HifRjns?=
 =?us-ascii?Q?yOkouowDPiZN5QDWV0gqiCMDQOkWld+EUIo6KgZ+MoGIkjB051AvC9s36vxS?=
 =?us-ascii?Q?2JdMWZit7gnhCGfHHtK+GGqvHNy8QSoVvzW7P7bTbyvI3I9t5brvoFMtahxS?=
 =?us-ascii?Q?bZfHpIZdEPcenzJW51HhQMS0sfIna+vmFf7VmJKFct3D5JtkvAiLlXO6G5Tc?=
 =?us-ascii?Q?DuM/vJkDY+XleXY+2s4JK6Gsb4UR/Z7D9vRjFc98oreYLMitqnvdApraKgY1?=
 =?us-ascii?Q?ZrrKySsUB0d4QYSU2YujrWEirR9syS0OjQ1LRVIXkgn1VeeKP/xrWtThRr2t?=
 =?us-ascii?Q?Y3r2ECWXiTFkkV3AfzwPkEQWMCvfBr+phXymsFLU9TlUjFlSA+R2vnPFJfDg?=
 =?us-ascii?Q?+gF805P7n8lwpwrpYq6hutEvzxV3bKcBoQyOnkdULPKRmrlKpH/ogucQhi3S?=
 =?us-ascii?Q?y9gyx/ip7mIxCIHZaB+6MWnei/rmlKvI5bT5Ihrf8m9jvhRdw+VUcHz7xvZx?=
 =?us-ascii?Q?oQOZ3WzX82VqYKdmoMJWe85y+1z+s6juKWLnOiRTgWjL6+46lfEJKFpW3v0I?=
 =?us-ascii?Q?O0SttlkLtl+8q1mCrHQ5Z8REZH57gE5g3eQcyRWOTPZWmTuZjSLPjMOaTLy+?=
 =?us-ascii?Q?84bhJ/xQp9I8x6VZuhYJdt6xPu2ekXs43e/vlJvUo09OUYNDJvGskTCq0QSh?=
 =?us-ascii?Q?CuBL8TDB6WZV2LBRLbsLgM0WgoBLNRBuB0jxPKsl0kyZjg29R1wf15sYihBA?=
 =?us-ascii?Q?aYATUKaTUX7hCZkAcCa2cEhBvwgRtCK2DzrVl1QmTJbZ9ciEnwk+dVskkOIh?=
 =?us-ascii?Q?sr2MSg4D4EQ13lHW3lNBYOzOKMcwlwNxO64e3I/gnFjPov6Rr37vPmzY7a5O?=
 =?us-ascii?Q?UImJP+MfDfZJINvOTd/GNcTyzsAm6RQybMwdcesH/1SEgkDuw6PmhRAgpXTG?=
 =?us-ascii?Q?86BYQHzeaG5oLq6eIHPF1Nvws4aKDNnicgbH5+BhYB+RaZVB8IfI4Y0XuqYp?=
 =?us-ascii?Q?NjLoDhUZGDSWMeZJo7BP7qczWovnthOnfNCfploYr0IaZSU4upxH6iKcJTrO?=
 =?us-ascii?Q?O8lh2K1elgUrCXOX6rR3QS9xobqdwfNcyd29/d38FcuQTYDCsuFo0KZGrVEk?=
 =?us-ascii?Q?RvzdNYmX5E3FfsHj2uhgAaz39S5YoA2hbR6hO1IHNn+bHy7due5DljOqhLy+?=
 =?us-ascii?Q?M4g75jBkaPJPGX0ZvmpGXnmVVcVl76CnE2XbmQRDlI1K1ocN0vlUWZwzkO2b?=
 =?us-ascii?Q?WOuhqsBlH7vDC2WVfc02Nf6VoHBfr8UO3w01+KlJW817ieVQYNVZsl5ghgkE?=
 =?us-ascii?Q?0/uN+UWTu02bHfhMHUN9ZhRyh6XnpJVsJsxohiYoRl+HJxOWggKAB6E2ke9y?=
 =?us-ascii?Q?wWasIK7NJM1lVUS95OkocBjt33r/4xXJ6a3BWID1kEb2IaEt8L34PJoJSaZm?=
 =?us-ascii?Q?wb9wWSZPuU/EwMofy2aCtbTCa6G+fPcB7DDzsTDmwv6xaL0AccCcPyi9bz0w?=
 =?us-ascii?Q?UXwl86PhOVKdP63sKtI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d32bf4-de98-4e07-9c92-08db70eb8447
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 17:35:04.1920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ySBJl0sTwVd9DH65UGQQk7MKJ/LJxe3/XeG/IXJ9ZO6HrxbIaBy/9n1eYWK8R5/pV7IZAMjQQ1n7B6t5dn2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
Subject: RE: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 1:26 PM

> > > Also these devices will use non-transitional ID but they in fact do
> > > have a legacy interface so using this definition they are
> > > transitional devices. Maybe we need to add when we describe the
> > > device ID text like "non transitional devices and transitional device=
s utilizing
> commands XYZ" ...?
> >
> > Transitional device has specific meaning, I am not sure we should muddy=
 it.
>=20
>=20
>=20
> To simplify transition from these earlier draft interfaces, a device MAY
> implement:
>=20
> \begin{description}
> \item[Transitional Device]
>         a device supporting both drivers conforming to this
>         specification, and allowing legacy drivers.
> \end{description}
>=20
>=20
> I agree it can be read this way. The issue is a lot of text in the spec j=
ust assumes
> that "has legacy interface =3D=3D transitional device".
>=20
>=20
>=20
> For example:
> When using the legacy interface the driver MAY access the device-specific
> configuration region using any width accesses, and a transitional device =
MUST
> present driver with the same results as when accessed using the ``natural=
''
> access method (i.e.
> 32-bit accesses for 32-bit fields, etc).
>=20
>=20
> If we break the assumption we need to audit the spec for this
> assumption and again, I really would rather not.

We are not breaking the assumption. Above listed requirement is already cap=
tured in the legacy interface conformance section.
So I am not sure what extra to write here.
=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

