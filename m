Return-Path: virtio-dev-return-6984-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76B7898602C
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Mar 2020 09:35:17 +0000 (UTC)
Date: Fri, 27 Mar 2020 10:35:07 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200327093507.GC4083132@myrica>
References: <20200323133831.2110014-1-jean-philippe@linaro.org>
 <55f19d89-ff7b-b3f6-d5f8-c2b31c23a38a@redhat.com>
 <20200326104933.GA2639913@myrica>
 <ac83718d-729d-84b4-93f4-43bde6256068@redhat.com>
 <MWHPR1801MB1966D5B702D86554421EE3D6E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <20200327090054.GB4083132@myrica>
 <MWHPR1801MB1966713697492AEF974ED528E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <MWHPR1801MB19664CB43F9CE2377B74C1E6E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR1801MB19664CB43F9CE2377B74C1E6E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Subject: [virtio-dev] Re: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add
 PAGE_SIZE_MASK property
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: Auger Eric <eric.auger@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 27, 2020 at 09:17:43AM +0000, Bharat Bhushan wrote:
>=20
> Sent again, somehow the email-address got corrupted.
>=20
> > -----Original Message-----
> > From: Bharat Bhushan
> > Sent: Friday, March 27, 2020 2:46 PM
> > To: =1B@mx0a-0016f401.pphosted.com
> > Cc: Auger Eric <eric.auger@redhat.com>; virtio-dev@lists.oasis-open.org
> > Subject: RE: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add
> > PAGE_SIZE_MASK property
> >=20
> > Hi Jean,
> >=20
> > > -----Original Message-----
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Sent: Friday, March 27, 2020 2:31 PM
> > > To: Bharat Bhushan <bbhushan2@marvell.com>
> > > Cc: Auger Eric <eric.auger@redhat.com>;
> > > virtio-dev@lists.oasis-open.org
> > > Subject: Re: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add
> > > PAGE_SIZE_MASK property
> > >
> > > On Fri, Mar 27, 2020 at 05:20:56AM +0000, Bharat Bhushan wrote:
> > > > Hi Jean,
> > > >
> > > > > -----Original Message-----
> > > > > From: Auger Eric <eric.auger@redhat.com>
> > > > > Sent: Thursday, March 26, 2020 4:50 PM
> > > > > To: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > Cc: virtio-dev@lists.oasis-open.org; Bharat Bhushan
> > > > > <bbhushan2@marvell.com>
> > > > > Subject: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add
> > > > > PAGE_SIZE_MASK property
> > > > >
> > > > > External Email
> > > > >
> > > > > -----------------------------------------------------------------=
-
> > > > > --
> > > > > --
> > > > > Hi Jean,
> > > > >
> > > > > On 3/26/20 11:49 AM, Jean-Philippe Brucker wrote:
> > > > > > On Mon, Mar 23, 2020 at 03:22:40PM +0100, Auger Eric wrote:
> > > > > >> Hi Jean,
> > > > > >>
> > > > > >> On 3/23/20 2:38 PM, Jean-Philippe Brucker wrote:
> > > > > >>> Add a PROBE property to declare the mapping granularity per e=
ndpoint.
> > > > > >>> The virtio-iommu device already declares a granule in its
> > > > > >>> config space, but when endpoints are behind different physica=
l
> > > > > >>> IOMMUs, they may have different mapping granules. This new
> > > > > >>> property allows to override the global page_size_mask for eac=
h endpoint.
> > > > > >>>
> > > > > >>> In the future it may be useful to describe more than one
> > > > > >>> page_size_mask for each endpoint, and allow them to negotiate
> > > > > >>> it during ATTACH. For example two masks could allow the drive=
r
> > > > > >>> to choose between 4k and 64k granule, along with their
> > > > > >>> respective block mapping sizes. This could be added by
> > > > > >>> replacing \field{reserved} with an array
> > > > > length, for example.
> > > > > >> Sorry I don't get the use case where several page size bitmaps
> > > > > >> should be exposed.
> > > > > >
> > > > > > For a 4k granule you get block mappings of 2M and 1G. For a 64k
> > > > > > granule you get 512M and 4T block mappings. If you want to
> > > > > > communicate both options to the guest, you need two separate
> > > > > > masks, 0x40201000 and 0x40020010000. Then the guest could choos=
e
> > > > > > one of the granules during attach, if we add a flag to the
> > > > > > attach request. I'm not suggesting we do that now, just trying
> > > > > > to make sure it can be extended if anyone actually wants it.
> > > > > > Personally I don't think it's worth adding, especially given th=
e
> > > > > > additional work required in
> > > the host.
> > > > > OK I get it now.
> > > >
> > > > What some clarification about two page-size-mask configurations ava=
ilable.
> > > >  - Global configuration for page-size-mask
> > > >  - per endpoint page-size-mask configuration
> > > >
> > > > PAGE_SIZE_MASK probe for and endpoint can return zero or non-zero v=
alue.
> > > > If it returns non-zero value than it will override the global confi=
guration.
> > > > If PAGE_SIZE_MASK probe for and endpoint return zero value than
> > > > global page-
> > > size-mask configuration will be used.
> > > >
> > > > Is that correct?
> > >
> > > Yes. If a PAGE_SIZE_MASK property is available for an endpoint, the
> > > driver should use that mask. Otherwise it should use the global mask,=
 which is
> > always provided.
> >=20
> > That mean even if the device return ZERO as page-size mask it will over=
ride global
> > page-size-mask configuration?
> > So device should not return PAGE_SIZE_MASK property when page-size-mask=
 not
> > set for that endpoint, that is zero?
> >=20
> > Or
> >=20
> > Device can return page-size-mask =3D 0 for the endpoint in PAGE_SIZE_MA=
SK
> > property, driver have to use global page-size-mask when PAGE_SIZE_MASK
> > property returns page-size-mask =3D 0.
> >=20

Ah sorry I didn't get the question. page_size_mask =3D=3D 0 isn't valid:

=09The device MUST set at least one bit in \field{page_size_mask},
=09describing the page granularity. The device MAY set more than one
=09bit in \field{page_size_mask}.

So the driver doesn't have to expect a value of 0, that would be a device
bug. If it wants to be on the safe side, then it rejects a page_size_mask
of 0 and use the global mask instead.

> > > I wonder, should we introduce some form of negotiation now?  If the
> > > driver doesn't know about the new probe property, it will use the
> > > global mask. At some point it will send a MAP request not aligned on
> > > the page granule, and the device will abort the request. If instead w=
e
> > > add a flag and page mask field to the attach request, the device woul=
d
> > > know that the driver didn't understand the per-endpoint page mask and=
 abort
> > the attach.
> >=20
> > What if device support PAGE_SIZE_MASK property  then it will always ret=
urn the
> > property, with zero or non-zero mask.
> > If zero mask, use global mask otherwise use per-endpoint mask.

My question is about device supports PAGE_SIZE_MASK property and driver
doesn't. For example a linux v4.6 guest would ignore the PAGE_SIZE_MASK
property. Then it will use the global mask, and send MAP requests that
aren't aligned on the per-endpoint page granule (they fail with S_RANGE
status). Should we, with the introduction of the PAGE_SIZE_MASK property,
also introduce a page size negotiation mechanism?  So that the device
knows early whether the guest understands or not the provided
PAGE_SIZE_MASK property?

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

