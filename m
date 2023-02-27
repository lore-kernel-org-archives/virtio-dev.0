Return-Path: <mst@redhat.com>
Date: Mon, 27 Feb 2023 02:34:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] transport-pci: Improve PCI legacy device layout
 description
Message-ID: <20230227023028-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-2-parav@nvidia.com>
 <20230225180014-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817FED59372B4F965B473FDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817FED59372B4F965B473FDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 27, 2023 at 03:02:10AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Saturday, February 25, 2023 6:09 PM
> > On Sun, Feb 26, 2023 at 12:29:59AM +0200, Parav Pandit wrote:
> > > Legacy interface PCI Device layout description has following issues.
> > >
> > > 1. repeated 'structure' word
> > > 2. virtio header was defined the 0.9.5 spec. In a legacy interface
> > >    section it is referred with different keywards
> > >    as (a) virtio header, (b) general headers, (c) legacy configuration
> > >    structure, (d) virtio common configuration structure and
> > >    (e) other fields.
> > > 3. Driver and device requirements listing is intermixed.
> > > 4. spelling error of structure
> > >
> > > Hence, rewrite the description to eliminate above issues as below.
> > >
> > > 1. Removed repeated structure word
> > > 2. Fix spelling of structure
> > > 3. Place all device requirements toegether 3. Define legacy
> > > configuration structure that consist of
> > >    a. legacy common configuration structure and
> > >    b. device specific configuration structure 4. Rewrite section
> > > around above changes
> > >
> > > This is only an editorial change.
> > 
> > No, editorial changes are things like spelling corrections.
> > 
> Got it. Will drop this remark.
> 
> > I have trouble reviewing
> > because I have no idea why you are making each change.
> > 
> After documenting legacy interface in the spec, we cannot claim that driver is the source = specification.

We document the *legacy interface*. What we don't is we don't document
legacy devices and drivers:

    Legacy devices and legacy drivers are not compliant with this
    specification.



> Currently transitional device and pci device do not scale well (or doesn't scale at all).
> We are working on supporting it and having better defined transitional device seems important part of it.
> 
> > E.g. you just rewrote a bunch of text and I frankly don't know why. For example:
> > 
> > 	-When using the legacy interface, transitional drivers
> > 	-MUST use the legacy configuration structure in BAR0 in the first
> > 	-I/O region of the PCI device, as documented below.
> > 
> > is now apparently:
> > 
> > 	+When used through the legacy interface, the legacy common
> > 	+configuration structure has the following layout:
> > 
> > and this is better? why? we are replacing a clear requirement which applied to
> 
> Because as I explained in the commit log, that one structure is named using 5 different names.

So maybe try just renaming. What you did is also convert a normative
statement to a non-normative one.


> > drivers with a vague statement which I can't say what it applies to.
> > 
> > Any chance of splitting these things up? Maybe that will help.
> > 
> That's a good idea. Yes. I will split these patches to smaller one.
> 
> > Apropos I don't know that we want to spend much time on legacy sections.
> Transitional devices are very much in use and documenting them well is important to build scalable transitional devices.
> 
> > Really with legacy code is the main source of documentation - if drivers work
> > then you are golden. If they don't appealing to spec will not help.
> 
> Yes, so don't want to add additional text. Just correcting the current one.

