Return-Path: <virtio-comment-return-3085-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 May 2022 09:07:57 +0100
Message-ID: <877d61wuc0.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] Next VirtIO device for Project Stratos?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Matt Spencer <Matt.Spencer@arm.com>, Peter Griffin <peter.griffin@linaro.org>, Dan Milea <dan.milea@windriver.com>, Bill Mills <bill.mills@linaro.org>, Francois Ozog <francois.ozog@linaro.org>, Johannes Berg <johannes@sipsolutions.net>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Christian Pinto <c.pinto@virtualopensystems.com>, Namhyung Kim <namhyung@kernel.org>, Petre Eftime <epetre@amazon.com>, Peter Hilber <peter.hilber@opensynergy.com>, Marcel Holtmann <marcel@holtmann.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi,

This email is driven by a brain storming session at a recent sprint
where we considered what VirtIO devices we should look at implementing
next. I ended up going through all the assigned device IDs hunting for
missing spec discussion and existing drivers so I'd welcome feedback
from anybody actively using them - especially as my suppositions about
device types I'm not familiar with may be way off!

Work so far
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The devices we've tackled so far have been relatively simple ones and
more focused on the embedded workloads. Both the i2c and gpio virtio
devices allow for a fairly simple backend which can multiplex multiple
client VM requests onto a set of real HW presented via the host OS.

We have also done some work on a vhost-user backend for virtio-video and
have a working PoC although it is a couple of iterations behind the
latest submission to the virtio spec. Continuing work on this is
currently paused while Peter works on libcamera related things (although
more on that later).

Upstream first
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We've been pretty clear about the need to do things in an upstream
compatible way which means devices should be:

  - properly specified in the OASIS spec
  - have at least one driver up-streamed (probably in Linux)
  - have a working public backend

for Stratos I think we are pretty happy to implement all new backends in
Rust under the auspices of the rust-vmm project and the vhost-device
repository.

We obviously also need a reasonable use case for why abstracting a HW
type is useful. For example i2c was envisioned as useful on mobile
devices where a lot of disparate auxillary HW is often hanging of an i2c
bus.

Current reserved IDs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Looking at the spec there are currently 42 listed device types in the
reserved ID table. While there are quite a lot that have Linux driver
implementations a number are nothing more than reserved numbers:

ioMemory / 6
------------

No idea what this was meant to be.

rpmsg / 7
---------

Not formalised in the specification but there is a driver in the Linux
kernel. AFAIUI I think it's a fairly simple wrapper around the existing
rpmsg bus. I think this has also been used for OpenAMP's hypervisor-less
VirtIO experiments to communicate between processor domains.

mac80211 wlan / 10
mac80211 hwsim wireless simulation device / 29
----------------------------------------------

When the discussion about a virtio-wifi come up there is inevitably a
debate about what the use case is. There are usually two potential use
cases:

  - simulation environment

    Here the desire is to have something that looks like a real WiFi
    device in simulation so the rest of the stack (up from the driver)
    can be the same as when running on real HW.

  - abstraction environment=20

    Devices with WiFi are different from fixed networking as they need
    to deal with portability events like changing networks and reporting
    connection status and quality. If the guest VM is responsible for
    the UI it needs to gather this information and generally wants it's
    userspace components to use the same kernel APIs to get it as it
    would with real HW.

Neither of these have up-streamed the specification to OASIS but there
is an implementation of the mac80211_hwsim in the Linux kernel. I found
evidence of a plain 80211 virtio_wifi.c existing in the Android kernel
trees. So far I've been unable to find backends for these devices but I
assume they must exist if the drivers do!

Debates about what sort of features and control channels need to be
supported often run into questions about why existing specifications
can't be expanded (for example expand virtio-net with a control channel
to report additional wifi related metadata) or use pass through sockets
for talking to the host netlink channel.

rproc serial / 11
-----------------

Again this isn't documented in the standard. I'm not sure if this is
related to rpmsg but there is an implementation as part of the kernel
virtio_console code.

virtio CAIF / 12
----------------

Not documented in the specification although there is a driver in the
kernel as part of the orphaned CAIF networking subsystem. From the
kernel documentation this was a sub-system for talking to modem parts.

memory balloon / 13
-------------------

This seems like an abandoned attempt at a next generation version of the
memory ballooning interface.

Timer/Clock device / 17
-----------------------

This looks like a simple reservation with no proposed implementation.

I don't know if there is a case for this on most modern architectures
which usually have virtualised architected timers anyway.

Access to RTC information may be something that mediated by
firmware/system control buses. For emulation there are a fair number of
industry standard RTC chips modelled and RTC access tends not to be
performance critical.

Signal Distribution Module / 21
-------------------------------

This appears to be a intra-domain communication channel for which an RFC
was posted:

 https://lists.oasis-open.org/archives/virtio-dev/201606/msg00030.html

it came with references to kernel and QEMU implementations. I don't know
if this approach has been obviated by other communcation channels like
vsock or scmi.

pstore device / 22
------------------

This appears to be a persistent storage device that was intended to
allow guests to dump information like crash dumps. There was a proposed
kernel driver:

  https://lwn.net/Articles/698744/

and a proposed QEMU backend:

  https://lore.kernel.org/all/1469632111-23260-1-git-send-email-namhyung@ke=
rnel.org/

which were never merged. As far as I can tell no proposal for the virtio sp=
ec itself.

Video encoder device / 30
Video decoder device / 31
-------------------------

This is an ongoing development which has iterated several versions of
the spec and the kernel side driver.=20

NitroSecureModule / 33
----------------------

This is a stripped down Trusted Platform Module (TPM) intended to expose
TPM functionality such as cryptographic functions and attestation to
guests. This looks like it is closely tied with AWS's Nitro Enclaves.

I haven't been able to find any public definition of the spec or
implementation details. How would this interact with other TPM
functionality solutions?

Watchdog / 35
-------------

Discussion about this is usually conflated with reset functionality as
the two are intimately related.

An early interest in this was for providing a well specified reset
functionality firmware running on the -M virt machine model in QEMU. The
need has been reduced somewhat with the provision of the sbsa-ref model
which does have a defined reset pin.

Other questions that would need to be answered include how the
functionality would interact with the hypervisor given a vCPU could
easily not be scheduled by it and therefore miss its kick window.

Currently there have been no proposals for the spec or implementations.

CAN / 36
--------

This is a device of interest to the Automotive industry as it looks to
consolidate numerous ECUs into VM based work loads. There was a proposed
RFC last year:

  https://markmail.org/message/hdxj35fsthypllkt?q=3Dvirtio-can+list:org%2Eo=
asis-open%2Elists%2Evirtio-comment

and it is presumed there are frontend and backend drivers in vendor
trees. At the last AGL virtualization expert meeting the Open Synergy
guys said they hoped to post new versions of the spec and kernel driver
soon:

  https://confluence.automotivelinux.org/pages/viewpage.action?spaceKey=3DV=
E&title=3DMeeting+Agenda#MeetingAgenda-May252022

During our discussion it became clear that while the message bus itself
was fairly simple real HW often has a vendor specific control plane to
enable specific features. Being able to present this flexibility via the
virtio interface without baking in a direct mapping of the HW would be
the challenge.

Parameter Server / 38
---------------------

This is a proposal for a key-value parameter store over virtio. The
exact use case is unclear but I suspect for Arm at least there is
overlap with what is already supported by DT and UEFI variables.

The proposal only seems to have been partially archived on the lists:

  https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07201.htm=
l

It may be Android related?

Audio policy device / 39
------------------------

Again I think this stems from the Android world and provides a policy
and control device to work in concert with the virtio-sound device. The
initial proposal to the list is here:

  https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07255.htm=
l

The idea seems to be to have a control layer for dealing with routing
and priority of multiple audio streams.=20

Bluetooth device / 40
---------------------

Bluetooth suffers from similar complexity problems as 802.11 WiFi.
However the virtio_bt driver in the kernel concentrates on providing a
pipe for a standardised Host Control Interface (HCI) albeit with support
for a selection of vendor specific commands.

I could not find any submission of the specification for standarisation.

Specified but missing backends?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

GPU device / 16
---------------

This is now a fairly mature part of the spec and has implementations is
the kernel, QEMU and a vhost-user backend. However as is commensurate
with the complexity of GPUs there is ongoing development moving from the
VirGL OpenGL encapsulation to a thing called GFXSTREAM which is meant to
make some things easier.

A potential area of interest here is working out what the differences
are in use cases between virtio-gpu and virtio-wayland. virtio-wayland
is currently a ChromeOS only invention so hasn't seen any upstreaming or
specification work but may make more sense where multiple VMs are
drawing only elements of a final display which is composited by a master
program. For further reading see Alyssa's write-up:

  https://alyssa.is/using-virtio-wl/

I'm not sure how widely used the existing vhost-user backend is for
virtio-gpu but it could present an opportunity for a more beefy rust-vmm
backend implementation?

Audio device / 25
-----------------

This has a specification and a working kernel driver. However there
isn't a working backend for QEMU although one has been proposed:

  Subject: [RFC PATCH 00/27] Virtio sound card implementation
  Date: Thu, 29 Apr 2021 17:34:18 +0530
  Message-Id: <20210429120445.694420-1-chouhan.shreyansh2702@gmail.com>

this could be a candidate for a rust-vmm version?

Other suggestions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

When we started Project Stratos there was a survey amongst members on
where there was interest.=20

virtio-spi/virtio-greybus
-------------------------

Yet another serial bus. We chose to do i2c but doing another similar bus
wouldn't be pushing the state of the art. We could certainly
mentor/guide someone else who wants to get involved in rust-vmm though.

virtio-tuner/virtio-radio
-------------------------

These were early automotive requests. I don't know where these would sit
in relation to the existing virtio-sound and audio policy devices.

virtio-camera
-------------

We have a prototype of virtio-video but as the libcamera project shows
interfacing with modern cameras is quite a complex task these days.
Modern cameras have all sorts of features powered by complex IP blocks
including various amounts of AI. Perhaps it makes more sense to leave
this to see how the libcamera project progresses before seeing what
common features could be exposed.

Conclusion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Considering the progress we've made so far and our growing confidence
with rust-vmm I think the next device we implement a backend for should
be a more complex device. Discussing this with Viresh and Mathieu
earlier today we thought it would be nice if the device was more demo
friendly as CLI's don't often excite.

My initial thoughts is that a rust-vmm backend for virtio-gpu would fit
the bill because:

  - already up-streamed in specification and kernel
  - known working implementations in QEMU and C based vhost-user daemon
  - ongoing development would be a good test of Rust's flexibility

I think virtio-can would also be a useful target for the automotive use
case. Given there will be a new release of the spec soon we should
certainly keep an eye on it.

Anyway I welcome peoples thoughts.

--=20
Alex Benn=C3=A9e

See also:

  Remaining Xen enabling work for rust-vmm - 87pmk472ii.fsf@linaro.org
  vhost-device outstanding tasks - 87zgj87alq.fsf@linaro.org


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

