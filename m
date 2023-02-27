Return-Path: <virtio-dev-return-11301-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B624CC64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:05:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 204122A82A
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:05:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16F2D986628
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:05:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0CE1B98640E; Mon, 27 Feb 2023 03:05:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDECE9863DD;
	Mon, 27 Feb 2023 03:05:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D487CxLlj0fZw71Devtk1BG5MHWpCKQOs0FhVOsUTnoxFuVVxwG8j4rZVbKex0DNtMZs5/zf4xvZUiWWlzEImq/xWOmaQZ9mDJ5NcfiQecV7agACXU2MQMJVetk5lO0As/+8FXtmV3s4k00wpqPuF0yK5+/PYVID/7hJBQvqX5yLKzA/ollg8zxwUhJjTO2MQpEfWZVzgsl85IUnNYpMfFgk1LJFtqaiCtA3V1BmsY995e8Q+5FaXXHVNMk20NX67iXmcRZbbg1uYklxiseix55A7p0IgMA+L2scZyjdyFGMbrBXGmNZKwEgpt2jiRIvaXJDWdMSkevlWd2l0GAEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiNYFVIJ6Z5bQMFsbhYv2uig0oY/c8oeIMUkF/lrhHM=;
 b=l9rkibJCJlilmcus8vkvqvMdCYxvwRuFU7JWLAvuzP4gfswAb2Tyl//MA3q5Mlq2nHd2Dkk0Fe+A01ImnyWwrVOe9fkgsr/qPmAggrPhcKT2rEt2qd5dmWlr4EwljgWgd/bRvqUKAJQF2/z7yad7k4lbYPkgRCWdG3v8q7JYvP4EA40zFhzF4KfcwU75T1nWscSnAk1fYFU48gUFPpYE4ljENhQk/hBSev4Sq4MezAWqj5bBOSoLZZCDXcZkBT25Cz2Hj+TEZd4PBvGMgkfs9+hQfzXu4OvSZdd/M/OoL3YZIquVhFeK2b2u9jRnl5QIrML/WF3qNd66RRzk1FOX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 2/3] transport-pci: Split notes of PCI Device Layout
Thread-Index: AQHZSWjGYtg9y2MCw0CMWWJyTPvcGa7gSzCAgAHR3QA=
Date: Mon, 27 Feb 2023 03:05:46 +0000
Message-ID: <PH0PR12MB54811C842A5C55065DABC71BDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-3-parav@nvidia.com>
 <20230225180932-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225180932-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7036:EE_
x-ms-office365-filtering-correlation-id: fe2040be-7cce-4d37-aaaa-08db186f8583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0jiHPxLOXgrwAilz569hxR1lwtBrak/OFhZsRLHSQAzdWYKU2cxd4qUA0oDL5wJNB8xRX94hnjIe5xpcKBTdtjI/w5/9dUGtOCM5WlOU7ozG59XDvLqpkWMpEFuFokb+8ERzNWb3WfjNzUvPlEcrhZLYMItMSuOYuyeD/fapxS093NBdkn59z4PKysqJMBJsdRjXN7pY8WmaE0Hu9yu+aaBVYBOhVTSA2WUc1R3li3q8/fb+IHxbiLor1TkUJ8NFs6xqYVoM7wDwxjjbsHfdQYhKdtmZN6XfSOMb+NcZeNpaFmIViXWBE47EAKyttEmDejZhz6PJugOxHwVwmsDe54M/ss72X82slRL71HuKxN6R+/ZV21Ov6h7yl/rU4VHD3/ekiT8p+0BYgM6hdDsYg++RcJIMau0ofM69mqFfxDEMZNzBqqehdVAk3bRsWiC8Ynk8KhEEBSN6gomE1jyMV78CcjERKZWDmGdOv3HulMUBhpgWMHZ5ou6DqDd32VA3Dcq8rjMuPMJzC81lSiKYIse9jBkJSE7BsjE37/tLdQ5v63ba5I+FgWaM7f/26RM4t+Mk5+J5jRgGBq8g/hLYlAjsSkZd03jGIWqCptmk7VbUDib2X9SkUhAHbOP0bW9pkmgNegfoyegiw1okMNDpWLdIHXQ9a+7sLAzxWhJHGSt5ggg1hOCoOO8S60q1lQp/h363Y122WtrSSF/nPWmWhHHG5quLC6/8rSV/rCYeLvusukJhTYjtzvKlP6MD+yFa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(316002)(54906003)(33656002)(86362001)(55016003)(38100700002)(122000001)(6506007)(107886003)(83380400001)(38070700005)(186003)(26005)(9686003)(5660300002)(71200400001)(8936002)(2906002)(7696005)(52536014)(966005)(478600001)(4326008)(41300700001)(8676002)(6916009)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qr92KJi5SCELY1kbI9GznzjPVdXsRKupEL2juWe5gFbibRbXjM3GUUxUcfsd?=
 =?us-ascii?Q?/mRqDEkor/WkkiHqQjtX495P/MTxs5t3W7b903Yq+PfLrPYQo082zgFfuc/0?=
 =?us-ascii?Q?hxEJ8yTDWNN8RvEt67k1AXHjj1cBAv3tAR0WfnZokxM9bM+zeX9J/6w/REFF?=
 =?us-ascii?Q?nPbG1fS09uKk6rZqs0BqLWronLU4JvyOUxwFJBRGXd3qgXtGmzXrI3+bEEVe?=
 =?us-ascii?Q?fV2re2wcbbBtU3bE8A6Jd/bt+SqZfha0J71NlXX5FdbebAKCFAeDxEcQvs6B?=
 =?us-ascii?Q?aBgQvTCVGz2li/+0uk+pJMi6nAo1naFMkbzqrG9JseqoEeWQ0bi+8irmG4rC?=
 =?us-ascii?Q?lxIS03ytzQ6W4JsfU2gl8uaYT6+Qbi6HylHEMpO5iETxQfrch9KFz2SbHTq3?=
 =?us-ascii?Q?GAareY/W9iccL4n64bgybOcVNiH0ZCVA3x6S3Y8NDiUIF5Tbw9h+QD5ox8Yq?=
 =?us-ascii?Q?3qU9gBDbbjqQBSicl6TDTdJadeKWxyzkD7VEIZR/w7tLnHVCDSRwsZxeTsgf?=
 =?us-ascii?Q?1F4L/24P0JeE4RjgIAGjpCezwWZEEe8tq6T5VHVap/gvzlKkDHZR0wmejU/S?=
 =?us-ascii?Q?LBPLvbJmTb10MwxEaX2WjSmI9hGDF/vpT5shMfYwIlhvfpxeJVc1f13EjS7N?=
 =?us-ascii?Q?nI8Xgb9M6ECHpUVjKNfjpplvp6ulnOHSraIM3yINKRQVfGlSscezXbUHHgMz?=
 =?us-ascii?Q?fshqN9nKdhNfXv/JhtrKu2FDTW5h2CLMlLDeTcziZAYpOPk0nLiVid7XgRyq?=
 =?us-ascii?Q?xjyQPNdiik76G/WWaoj1JaYy/vJPmRTufwoL5HZSQC7Ed3MDqB5SFTSTHvWp?=
 =?us-ascii?Q?8LU0uzf057lZdktv/N4SzWQ/j5G2IW/Qrbdk/ZD6UCxNEwjiWPGfKQGxIj+E?=
 =?us-ascii?Q?JAjBDGydmPlulmS6LpJj9bBcETsJJoKdUOrdBHZEb34ZPb7Jned+Mx5VmOTO?=
 =?us-ascii?Q?EdGXVgNk5icZrSROn1+GMFcC4y/CRk4SFCoHW3ewzngaI7jUGajg5cbOGo/2?=
 =?us-ascii?Q?3/zeH3qkWKG40BlzV8eDS/oE7MC22x3g8sOVxJ5P08942YOhYdZ5PSI9kQpI?=
 =?us-ascii?Q?YK/45gj29vYKVZbFebLSk+ksVb4Am02cA7jcTA1ZHIUb7dT7Gq0yLDWziUGz?=
 =?us-ascii?Q?VpAfXyvsLSgk1IiMM1b4Orlpty4oSup97dy05p68UGtt7/RicL3L6yX+XVkl?=
 =?us-ascii?Q?ZDWQUrk1mr56ZhRIoQVkNVFfFwKyzSe2fOgn7ui+zyfQi2zBFh9NOmFa6p9O?=
 =?us-ascii?Q?0LlHabm/rdwihQNrC3EHbIHAOHm47CYlsD3Ez3qXle9t6+GejyDv8eVPFm5p?=
 =?us-ascii?Q?iLGRN/x/75kuJ8Y/shUxRTUqPIPqTfOTfY0PWSS4J/lcYIOgrdtlxXf8nZOq?=
 =?us-ascii?Q?6EtLj3uMGx3uLQ5Fp4V+TDZhhzJVuYCzJ8dVg7oT0ucOOj8WkNAXYs56wYuA?=
 =?us-ascii?Q?5XCkdyX9N6jnRW09FoMGXdCweEbWFoZd/E2uhGmw2+z/HRTOOL/gD6gsl5rg?=
 =?us-ascii?Q?SDzerhQc7ZGecuFU4pIoWiIdMFITP3VYmBTUtm0pd6v3fpspTXEO6wBRiyG6?=
 =?us-ascii?Q?P9fR/p1VF885QheBgww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2040be-7cce-4d37-aaaa-08db186f8583
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 03:05:46.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCoWYqUp9xeVawPhxIcY3riKUXO3P5izZvsEIj4peFsSFuihynhJuwgn6XjoWOcGD0/A2V3eZx6jfbHfPJP0OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
Subject: [virtio-dev] RE: [PATCH 2/3] transport-pci: Split notes of PCI Device Layout
Message-ID: <20230227030546.9lYj-MKQeR_1Oe9xhlTmmRnUVVIM0ZVh-vOsywXQdMs@z>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 6:15 PM
>=20
> On Sun, Feb 26, 2023 at 12:30:00AM +0200, Parav Pandit wrote:
> > Currently single legacy interface section describes PCI common
> > configuration layout and feature bits operation for the legacy
> > interface.
> > Secondly common configuration structure description of legacy
> > interface is not adjacent to the the respective normal device
> > requirements for same.
> >
> > Hence, split PCI Device Layout legacy interface section into two
> > parts. First subsection for common configuration and second subsection
> > for feature bits.
> >
> > Subsequent patch relocates common configuration legacy interface to
> > appropriate matching location.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> I don't care really. However this does much more than move text around as=
 it
> claim to do:
>=20
>=20
> > ---
> >  conformance.tex   |  4 +++-
> >  transport-pci.tex | 19 ++++++++++++-------
> >  2 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/conformance.tex b/conformance.tex index 01ccd69..0d3616f
> > 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -262,7 +262,9 @@ \section{Conformance
> > Targets}\label{sec:Conformance / Conformance Targets}  \item Section
> > \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message
> > Framing / Legacy Interface: Message Framing}  \item Section
> > \ref{sec:General Initialization And Device Operation / Device
> > Initialization / Legacy Interface: Device Initialization}  \item
> > Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI
> > Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
> > -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus
> > / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> > +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI
> > +Bus/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on
> > +Common configuration Layout} \item Section \ref{sec:Virtio Transport
> > +Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities /
> > +Legacy Interface: A Note on feature bits}
> >  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus
> > / PCI-specific Initialization And Device Operation / Device
> > Initialization / Virtio Device Configuration Layout Detection / Legacy
> > Interface: A Note on Device Layout Detection}  \item Section
> > \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific
> > Initialization And Device Operation / Device Initialization /
> > Virtqueue Configuration / Legacy Interface: A Note on Virtqueue
> > Configuration}  \item Section \ref{sec:Virtio Transport Options /
> > Virtio Over MMIO / Legacy interface} diff --git a/transport-pci.tex
> > b/transport-pci.tex index 9ee37ba..9d4c713 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -767,7 +767,10 @@ \subsubsection{PCI configuration access
> > capability}\label{sec:Virtio Transport O  specified by some other
> > Virtio Structure PCI Capability  of type other than
> \field{VIRTIO_PCI_CAP_PCI_CFG}.
> >
> > -\subsubsection{Legacy Interfaces: A Note on PCI Device
> > Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI
> > Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> > +\subsubsection{Legacy Interfaces: A Note on Common configuration
> > +Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> > +Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on
> > +Common configuration Layout}
> >
> >  The transitional device MUST present part of the configuration
> > registers in a legacy configuration structure in BAR0 in the
>=20
>=20
> Please do not split up labels to multiple lines like this, it is hard to =
find and fix
> them if you do.
>=20
Will fix it.

> > @@ -852,13 +855,15 @@ \subsubsection{Legacy Interfaces: A Note on PCI
> > Device Layout}\label{sec:Virtio  is encoded in the native endian of
> > the guest (where such  distinction is applicable).
> >
> > -When accessing the device-specific configuration structure -using the
> > legacy interface, transitional drivers MUST access -the
> > device-specific configuration structure -at an offset immediately
> > following the legacy common -configuration structure.
> > +The transitional driver when using the legacy interface MUST the
> > +device-specific configuration structure at an offset immediately
> > +following the legacy common configuration structure.
>=20
> Oh great and in the process of presumably just moving stuff around you ar=
e
> also losing text - the result is agrammatical, and much less clear than t=
he
> original.
>=20
I missed "access".
While splitting the patch, a hunk got in the wrong patch.
Will fix it.
Thank for the catch.

>=20
> >
> > -Note that only Feature Bits 0 to 31 are accessible through the
> > +\subsubsection{Legacy Interface: A Note on feature
> > +bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> > +Virtio Structure PCI Capabilities / Legacy Interface: A Note on
> > +feature bits}
> > +
> > +Only Feature Bits 0 to 31 are accessible through the
> >  Legacy Interface. When used through the Legacy Interface,  the
> > transitional device MUST assume that Feature Bits 32 to 63  are not
> > acknowledged by the driver.
>=20
> And you are dropping "Note" here because why? Seems notable in that there
> are more feature bits, someone might miss this fact.
The heading is "A Note ..."
Hence, I dropped the Note from the sentence.
But if you really care, can add it back...

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

