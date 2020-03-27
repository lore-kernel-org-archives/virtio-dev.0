Return-Path: virtio-dev-return-6983-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40AB798602C
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Mar 2020 09:01:05 +0000 (UTC)
Date: Fri, 27 Mar 2020 10:00:54 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200327090054.GB4083132@myrica>
Reply-To: ""@lists.oasis-open.org
References: <20200323133831.2110014-1-jean-philippe@linaro.org>
 <55f19d89-ff7b-b3f6-d5f8-c2b31c23a38a@redhat.com>
 <20200326104933.GA2639913@myrica>
 <ac83718d-729d-84b4-93f4-43bde6256068@redhat.com>
 <MWHPR1801MB1966D5B702D86554421EE3D6E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR1801MB1966D5B702D86554421EE3D6E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Subject: [virtio-dev] Re: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add
 PAGE_SIZE_MASK property
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: Auger Eric <eric.auger@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 27, 2020 at 05:20:56AM +0000, Bharat Bhushan wrote:
> Hi Jean,
>=20
> > -----Original Message-----
> > From: Auger Eric <eric.auger@redhat.com>
> > Sent: Thursday, March 26, 2020 4:50 PM
> > To: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: virtio-dev@lists.oasis-open.org; Bharat Bhushan <bbhushan2@marvell.=
com>
> > Subject: [EXT] Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add PAGE_=
SIZE_MASK
> > property
> >=20
> > External Email
> >=20
> > ----------------------------------------------------------------------
> > Hi Jean,
> >=20
> > On 3/26/20 11:49 AM, Jean-Philippe Brucker wrote:
> > > On Mon, Mar 23, 2020 at 03:22:40PM +0100, Auger Eric wrote:
> > >> Hi Jean,
> > >>
> > >> On 3/23/20 2:38 PM, Jean-Philippe Brucker wrote:
> > >>> Add a PROBE property to declare the mapping granularity per endpoin=
t.
> > >>> The virtio-iommu device already declares a granule in its config
> > >>> space, but when endpoints are behind different physical IOMMUs, the=
y
> > >>> may have different mapping granules. This new property allows to
> > >>> override the global page_size_mask for each endpoint.
> > >>>
> > >>> In the future it may be useful to describe more than one
> > >>> page_size_mask for each endpoint, and allow them to negotiate it
> > >>> during ATTACH. For example two masks could allow the driver to
> > >>> choose between 4k and 64k granule, along with their respective bloc=
k
> > >>> mapping sizes. This could be added by replacing \field{reserved} wi=
th an array
> > length, for example.
> > >> Sorry I don't get the use case where several page size bitmaps shoul=
d
> > >> be exposed.
> > >
> > > For a 4k granule you get block mappings of 2M and 1G. For a 64k
> > > granule you get 512M and 4T block mappings. If you want to communicat=
e
> > > both options to the guest, you need two separate masks, 0x40201000 an=
d
> > > 0x40020010000. Then the guest could choose one of the granules during
> > > attach, if we add a flag to the attach request. I'm not suggesting we
> > > do that now, just trying to make sure it can be extended if anyone
> > > actually wants it. Personally I don't think it's worth adding,
> > > especially given the additional work required in the host.
> > OK I get it now.
>=20
> What some clarification about two page-size-mask configurations available=
.
>  - Global configuration for page-size-mask
>  - per endpoint page-size-mask configuration
>=20
> PAGE_SIZE_MASK probe for and endpoint can return zero or non-zero value.
> If it returns non-zero value than it will override the global configurati=
on.
> If PAGE_SIZE_MASK probe for and endpoint return zero value than global pa=
ge-size-mask configuration will be used.
>=20
> Is that correct?

Yes. If a PAGE_SIZE_MASK property is available for an endpoint, the driver
should use that mask. Otherwise it should use the global mask, which is
always provided.

I wonder, should we introduce some form of negotiation now?  If the driver
doesn't know about the new probe property, it will use the global mask. At
some point it will send a MAP request not aligned on the page granule, and
the device will abort the request. If instead we add a flag and page mask
field to the attach request, the device would know that the driver didn't
understand the per-endpoint page mask and abort the attach.

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

