Return-Path: virtio-dev-return-6997-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53C19986036
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Mar 2020 11:39:59 +0000 (UTC)
Date: Fri, 27 Mar 2020 12:39:47 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200327113947.GA4102422@myrica>
References: <20200323133831.2110014-1-jean-philippe@linaro.org>
 <55f19d89-ff7b-b3f6-d5f8-c2b31c23a38a@redhat.com>
 <20200326104933.GA2639913@myrica>
 <ac83718d-729d-84b4-93f4-43bde6256068@redhat.com>
 <MWHPR1801MB1966D5B702D86554421EE3D6E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <20200327090054.GB4083132@myrica>
 <MWHPR1801MB1966713697492AEF974ED528E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <MWHPR1801MB19664CB43F9CE2377B74C1E6E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <20200327093507.GC4083132@myrica>
 <dd4e26c6-1623-726d-e46b-9a9ce162e67d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dd4e26c6-1623-726d-e46b-9a9ce162e67d@redhat.com>
Subject: Re: [virtio-dev] Re: [EXT] Re: [virtio-dev] Re: [RFC PATCH]
 virtio-iommu: Add PAGE_SIZE_MASK property
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Auger Eric <eric.auger@redhat.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 27, 2020 at 12:05:42PM +0100, Auger Eric wrote:
> Hi Jean, Bharat,
>=20
> On 3/27/20 10:35 AM, Jean-Philippe Brucker wrote:
> > On Fri, Mar 27, 2020 at 09:17:43AM +0000, Bharat Bhushan wrote:
> >>
> >> Sent again, somehow the email-address got corrupted.
> >>
> >>> -----Original Message-----
> >>> From: Bharat Bhushan
> >>> Sent: Friday, March 27, 2020 2:46 PM
> >>> To: =1B@mx0a-0016f401.pphosted.com
> >>> Cc: Auger Eric <eric.auger@redhat.com>; virtio-dev@lists.oasis-open.o=
rg
> >>> Subject: RE: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add
> >>> PAGE_SIZE_MASK property
> >>>
> >>> Hi Jean,
> >>>
> >>>> -----Original Message-----
> >>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>>> Sent: Friday, March 27, 2020 2:31 PM
> >>>> To: Bharat Bhushan <bbhushan2@marvell.com>
> >>>> Cc: Auger Eric <eric.auger@redhat.com>;
> >>>> virtio-dev@lists.oasis-open.org
> >>>> Subject: Re: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Ad=
d
> >>>> PAGE_SIZE_MASK property
> >>>>
> >>>> On Fri, Mar 27, 2020 at 05:20:56AM +0000, Bharat Bhushan wrote:
> >>>>> Hi Jean,
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Auger Eric <eric.auger@redhat.com>
> >>>>>> Sent: Thursday, March 26, 2020 4:50 PM
> >>>>>> To: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>>>>> Cc: virtio-dev@lists.oasis-open.org; Bharat Bhushan
> >>>>>> <bbhushan2@marvell.com>
> >>>>>> Subject: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add
> >>>>>> PAGE_SIZE_MASK property
> >>>>>>
> >>>>>> External Email
> >>>>>>
> >>>>>> ------------------------------------------------------------------
> >>>>>> --
> >>>>>> --
> >>>>>> Hi Jean,
> >>>>>>
> >>>>>> On 3/26/20 11:49 AM, Jean-Philippe Brucker wrote:
> >>>>>>> On Mon, Mar 23, 2020 at 03:22:40PM +0100, Auger Eric wrote:
> >>>>>>>> Hi Jean,
> >>>>>>>>
> >>>>>>>> On 3/23/20 2:38 PM, Jean-Philippe Brucker wrote:
> >>>>>>>>> Add a PROBE property to declare the mapping granularity per end=
point.
> >>>>>>>>> The virtio-iommu device already declares a granule in its
> >>>>>>>>> config space, but when endpoints are behind different physical
> >>>>>>>>> IOMMUs, they may have different mapping granules. This new
> >>>>>>>>> property allows to override the global page_size_mask for each =
endpoint.
> >>>>>>>>>
> >>>>>>>>> In the future it may be useful to describe more than one
> >>>>>>>>> page_size_mask for each endpoint, and allow them to negotiate
> >>>>>>>>> it during ATTACH. For example two masks could allow the driver
> >>>>>>>>> to choose between 4k and 64k granule, along with their
> >>>>>>>>> respective block mapping sizes. This could be added by
> >>>>>>>>> replacing \field{reserved} with an array
> >>>>>> length, for example.
> >>>>>>>> Sorry I don't get the use case where several page size bitmaps
> >>>>>>>> should be exposed.
> >>>>>>>
> >>>>>>> For a 4k granule you get block mappings of 2M and 1G. For a 64k
> >>>>>>> granule you get 512M and 4T block mappings. If you want to
> >>>>>>> communicate both options to the guest, you need two separate
> >>>>>>> masks, 0x40201000 and 0x40020010000. Then the guest could choose
> >>>>>>> one of the granules during attach, if we add a flag to the
> >>>>>>> attach request. I'm not suggesting we do that now, just trying
> >>>>>>> to make sure it can be extended if anyone actually wants it.
> >>>>>>> Personally I don't think it's worth adding, especially given the
> >>>>>>> additional work required in
> >>>> the host.
> >>>>>> OK I get it now.
> >>>>>
> >>>>> What some clarification about two page-size-mask configurations ava=
ilable.
> >>>>>  - Global configuration for page-size-mask
> >>>>>  - per endpoint page-size-mask configuration
> >>>>>
> >>>>> PAGE_SIZE_MASK probe for and endpoint can return zero or non-zero v=
alue.
> >>>>> If it returns non-zero value than it will override the global confi=
guration.
> >>>>> If PAGE_SIZE_MASK probe for and endpoint return zero value than
> >>>>> global page-
> >>>> size-mask configuration will be used.
> >>>>>
> >>>>> Is that correct?
> >>>>
> >>>> Yes. If a PAGE_SIZE_MASK property is available for an endpoint, the
> >>>> driver should use that mask. Otherwise it should use the global mask=
, which is
> >>> always provided.
> >>>
> >>> That mean even if the device return ZERO as page-size mask it will ov=
erride global
> >>> page-size-mask configuration?
> >>> So device should not return PAGE_SIZE_MASK property when page-size-ma=
sk not
> >>> set for that endpoint, that is zero?
> >>>
> >>> Or
> >>>
> >>> Device can return page-size-mask =3D 0 for the endpoint in PAGE_SIZE_=
MASK
> >>> property, driver have to use global page-size-mask when PAGE_SIZE_MAS=
K
> >>> property returns page-size-mask =3D 0.
> >>>
> >=20
> > Ah sorry I didn't get the question. page_size_mask =3D=3D 0 isn't valid=
:
> >=20
> > =09The device MUST set at least one bit in \field{page_size_mask},
> > =09describing the page granularity. The device MAY set more than one
> > =09bit in \field{page_size_mask}.
> >=20
> > So the driver doesn't have to expect a value of 0, that would be a devi=
ce
> > bug. If it wants to be on the safe side, then it rejects a page_size_ma=
sk
> > of 0 and use the global mask instead.
>=20
> So I think on device's side, the best is to not return any
> PAGE_SIZE_MASK property for an ep which does not have any special
> limitation (for instance a virtio EP), as opposed to a VFIO EP, right?
> Supporting this probe property does not mean we always report it, right?

No we don't have to report for devices without special limitations, since
it would be the same as global mask anyway

> >=20
> >>>> I wonder, should we introduce some form of negotiation now?  If the
> >>>> driver doesn't know about the new probe property, it will use the
> >>>> global mask. At some point it will send a MAP request not aligned on
> >>>> the page granule, and the device will abort the request. If instead =
we
> >>>> add a flag and page mask field to the attach request, the device wou=
ld
> >>>> know that the driver didn't understand the per-endpoint page mask an=
d abort
> >>> the attach.
> >>>
> >>> What if device support PAGE_SIZE_MASK property  then it will always r=
eturn the
> >>> property, with zero or non-zero mask.
> >>> If zero mask, use global mask otherwise use per-endpoint mask.
> >=20
> > My question is about device supports PAGE_SIZE_MASK property and driver
> > doesn't. For example a linux v4.6 guest would ignore the PAGE_SIZE_MASK
> > property. Then it will use the global mask, and send MAP requests that
> > aren't aligned on the per-endpoint page granule (they fail with S_RANGE
> > status). Should we, with the introduction of the PAGE_SIZE_MASK propert=
y,
> > also introduce a page size negotiation mechanism?  So that the device
> > knows early whether the guest understands or not the provided
> > PAGE_SIZE_MASK property?
>=20
> On std iommu drivers, the check also is done on map, right?

The host device needs to check alignment:

  If virt_start, phys_start or (virt_end + 1) is not aligned on the page
  granularity, the device SHOULD reject the request and set status to
  VIRTIO_IOMMU_S_RANGE.

I think host VFIO checks all of these.

Guest IOMMU drivers will base their mappings on the page granule, but that
granule may be wrong if they ignored the PAGE_SIZE_MASK property of an
endpoint.

> If so, and given the current known user pool, I would leave it as it is
> today.

Agreed with this

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

