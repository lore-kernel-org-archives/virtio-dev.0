Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481DB5D0F4F3EAAEB26B047DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481C5C0EB93191416E36D4EDCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211014182437-mutt-send-email-mst@kernel.org> <DM8PR12MB54806B9EEECE8920F450F86BDCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <047032b5-6b39-98cb-8517-2b02e5fb1560@redhat.com> <PH0PR12MB5481E5C62AD72F75792FC9B6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs7gAipdbkj4DrpWLsxViHK_qicFVjy6Dy4qP7argih4g@mail.gmail.com>
 <PH0PR12MB548105873DCFFDE8FD95D0A6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEthjkX3pV+1L9Eg-nJOArSUfmDRY8UCK_2LJ7-oxO6SpQ@mail.gmail.com>
 <DM8PR12MB548048016A0311F809BF0E67DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <CACGkMEuP6nZCSyz8piHYdMzwSKGgZbn65SBx486C-Lm2jbw5TA@mail.gmail.com>
 <PH0PR12MB5481C32F9D9A54AFA4E337A3DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2984c445-a7fd-97c4-34aa-3a40778a0fcd@redhat.com> <PH0PR12MB54810528108E4EB12CC1C401DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54810528108E4EB12CC1C401DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 12:03:52 +0800
Message-ID: <CACGkMEtBJavHQr2SaMiz8TSTt-fCsm3WoJMfRYEO=dr-=Ld-1Q@mail.gmail.com>
Subject: Re: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 25, 2021 at 2:11 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, October 25, 2021 11:12 AM
> [..]
> > So what I meant is, if PCI gives us an upper limit of the reset (e.g 10=
0ms as you
> > said), can virtio device perform reset more than that? If not, can we s=
imply use
> > 100ms for virtio-pci or can we gain from having a smaller per device ti=
meout?
> > If yes, it looks like a violation for PCI.
> No. Not at all a violation of PCI spec.
> PCI spec is transport layer.
> Virtio io is layer above transport.
>
> PCI device can be reset, but not necessary, it is ready to service upper =
layer protocols who may need more time to finish the reset.

Isn't transport level reset implies a virtio reset? I think this is
the question we need to answer or clarify it in the spec. All my
suggestions were based on the answer "yes".

Another question is that we don't define reset actually, do we need to
do that before trying to define reset timeout? To me the reset means
the device can be used by the driver which means all the basic device
facilities are ready. It means the device is ready from the
perspective of a "driver", if the device requires a connection to a
remote subsystem, whether or not such connection is established is out
of the scope of virtio reset. Devices can choose not to process the
requests from the virtqueue.

Another question is that, can we present a PCI device if the
underlayer device logic is not ready? If the question is yes, do we
need a new facility to tell the driver that the device is being
initialized?

>
> There are several examples of it in industry today.
> nvme, mlx5, efa, intel ice and more who may need more time to reset the u=
pper layer device tan 100msec.

Virtio supports more types than the above list, if it's the timeout
that is specific to some types of the devices (e.g block), we need to
use device specific methods.

>
> second point that I already explained, is there is nothing wrong at the P=
CI level that _requires_ further reset.
> PCI device is just fine, it is under reset by virtio. Depending on the de=
vice implementation it just takes more time.
> In few responses in the thread, I already described those different types=
 of devices in response to Cornelia and Michael.
> Please go through the thread. Let's not repeat the same discussion again.

So my point is to avoid exposing any implementation specific to the
driver. It has a different movitiaton than the discussion you refer to
here.

>
> >
> > It looks to there're many choices
> >
> > 1) driver reset timeout via module parameter or sysfs
> > 2) transport driver reset timeout (e.g via virtio-pci)
> > 3) device reset timeout
> >
> > If we can solve the issue in 1) and 2), there's no need for 3) consider
> > 3) requires a changes is various places and may bring extra troubles.
> >
> What are those extra troubles?
> Device reset timeout is addressing #1, #2 and #3 without any of the extra=
 user config knobs. This delivers less painful systems to user and also ven=
dor agnostic method.
>
> Actually sysfs is more troublesome, where user needs to reboot the system=
 and do scripts to configure these values even before kernel-builtin module=
s are loaded.
> Some pre-boot env, doesn=E2=80=99t have such sysfs.

It's just an example, it could be a hard coded value. If 100ms is not
enough we can use something longer.

>
> >
> > >
> > >> It looks to me it will guarantee the success of the reset?
> > > You are describing the timeout expiration handling.
> >
> >
> > This looks more important than just having a device hint of the timeout=
.
> > We don't want to block thing like module unload or device removal etc.
> >
> We already discussed in this thread with Michael, that a device which is =
already reseted before, a second reset should be fast to service anyway.

Well, this part I don't understand. If you meant the time spent on the
"first" reset is implementation dependent but time spent on the
"second" reset is fast (not much implementation dependent). It looks
like a conclusion that applies only to your specific implementation or
hardware.

> Please read the discussion in this thread. Let's not repeat the same disc=
ussion again.

It's not a repeat of the discussion, we don't want to end up with a
solution that works only for a single vendor or implementation.

> > >>> Still not any different than rest of the RW capabilities/registers.
> > >> So the timeout doesn't work if we can enforce that.
> > > Didn=E2=80=99t follow your comment. Enforce what?
> >
> >
> > I meant the timeout value doesn't work here since guest can't see that.
> Your example was for VM migration from sw_without_device_reset to hw_with=
_device_reset.
> And here, you wanted to hide the device reset timeout.
> So guest _should_not_ be able to see it. Right?

Yes, so if the hardware can work with the infinite waiting in the
guest, there's no much value for the device specific reset timeout
actually. Isn't it?

>
> >
> >
> > >
> > >> Seems sub optimal than doing a transport reset if possible.
> > > Transport level reset is not helpful for two main reasons.
> > > 1. A device under reset has nothing wrong at the PCI level.
> > > Device is just still under boot/resetting to service virtio level com=
mands.
> > > So doing PCI level reset is actually adversely affect it further beca=
use PCI
> > level reset will trigger more layers of unwanted reset.
> >
> >
> > Well, looking at the driver codes, there're various places that the
> > reset() is not expected to be fail. My understanding is that your
> > proposal only solve the issue when the reset can fail but not other.
> > That's why we need seek help for transport layer support.
> >
> Driver can issue transport level reset when reset timeout expires.
> First we need the reset timeout to be defined and let it expire. :)
> Once it expires, sure, transport level resets can be applied.

Yes, but I'm not sure how device specific timeout can help more:

1) if device works well, there won't be an infinite wait on the reset
2) if device is buggy,
2.1) wait for ever
2.2) doing a transport specific reset to prevent data corruption after a ti=
meout

Using 2.2 is tricky since as discussed, the hypervisor may choose to
hide this and let guests just use infinite wait for most of the cases.

>
> I think you missed this part, that we do not reset to wait infinitely in =
all places as done today in linux driver.

The reason is that virtio drivers are mostly used in the guest where
the device is emulated by the software. It's almost impossible to
enforce a timeout for any specific operation, setting device status is
just one of the possible operations that may wait forever.

> Wait finitely, and when finite time expires, sure, driver can issue trans=
port level reset.

Ok, so I think if we finally go with the way of the device advertised
timeout, we need to clarify the transport level reset is a must after
timeout in the spec anyhow.

>
> >
> > >
> > > 2. PCI level reset must complete in 100msec.
> >
> >
> > Did you mean 100ms is too long? If yes, please explain why.
> This is discussed and Cornelia gave the example also in this thread.
> i.e. a fw based hw virtio device may not have finished its initialization=
 in its 100 msec.
> so virtio layer may need to wait longer.

Yes, but current code without timeout works in this case.

>
> >
> >
> > >
> > > I still don't understand mixing transport level reset with virtio lev=
el reset in
> > context of LM.
> > >
> > > If I read your original concern, that a sw device was exposed on HV-1=
 without
> > device reset timeout.
> > > And now user wants to migrate this VM to HV-2 which has a hw device w=
ith
> > device reset timeout.
> > > And now this device cannot be passed to the HV-2 because older sw dev=
ice
> > was attached to the VM.
> > > I am frankly not sure, if this is really a case to consider.
> >
> >
> > Actually, it's a choice of the cloud vendors. But consider there are
> > very huge number of instances which is based on software virtio, it's a
> > valid use case. But what I want to say is that, if we touch the spec, i=
t
> > will requires changes in the management layer as well. E.g if we can no=
t
> > migrate from hardware that support reset timeout to software that
> > doesn't support reset timeout. It will be better if we can do that only
> > in the driver.
> Above explanation chooses now a different example.
> In this example, you mention hw to sw migration.
> Previously your example was from inferior sw to newer hw.

It just to demonstrate possible troubles:

1) migrate from sw(no timeout) to hw (timeout)
2) migrate from hw(timeout) to sw(no timeout)
3) migrate from hw_vendorA(timeoutA) to hw_vendorB(timeoutB)
4) migrate from hw_vendorA(timeoutA_implementationA) to
hw_vendorA(timeoutB_implementationB)
5) migrate from hw_vendorA(timeoutA_implementationA) to
hw_vendorA(timeoutA_implementationA)

The hypervisor can only choose to expose timeout value in the case 5)
(and it can only do this if it knows all the migration destinations
have the same timeout value) and it will let the 1 to 4 to simply use
infinite wait by hiding the capability. The management stack should
have virtio specific knowledge to poke into the PCIE capabilities list
to find and report the timeout and we need cross machine co-ordination
with the migration destination or clusters to allow the migration.
Hypervisors like Qemu maintain the migration compatibility by using
machine type, but this implementation specific attributes makes it
almost impossible to be a part of the machine type which means virtio
ad-hoc codes were needed.

>
> >
> > Similar but one more burden for the management if a simple 100ms timeou=
t
> > can work for virtio-pci.
> Resilient spec and resilient sw, hw stack is not a burden to management s=
tack.
> It is just any other hw/sw attribute of the virtio device to take care.

This is only true if you don't expose any vendor or implementation
specific attributes. See above.

>
> >
> > > In another MSI-X example you provided emulated MSIX alterative was
> > proposed. This is again not mapping the full hw device.
> > >
> > > So it is still sw device on other hand. User might as well just conti=
nue in sw
> > mode.
> > >
> > > Let's assume for a moment that, this (rare) case should be considered=
.
> > >
> > > Once way to overcome this is below.
> > > (a) Do not place new device_reset_timeout field in struct
> > virtio_pci_common_cfg.
> > > This is because this map be in memory mapped BAR directly accessible =
to the
> > guest and future version of the spec has more fields after device reset=
 timeout.
> > > Such fields are somehow implemented by the sw device on HV-1.
> > >
> > > (b) Instead, define new cfg_type VIRTIO_PCI_CAP_DEV_TIMEOUT_CFG.
> > > This points to the struct containing device reset timeout.
> > > Exposing this capability can be skipped when mapping the hw virtio de=
vice to
> > VM on HV-2 to match sw virtio device of HV-1.
> >
> >
> > This will ease the hypervisor but anyhow hypervisor can choose to not
> > expose the capability directly to guest (which will soon became a burde=
n
> > to support cross vendor live migration).
> Again it is not a burden.
> If a live migration sw needs the ability to migrate between vendors, righ=
t approach is to have attributes in the spec.
> So that sw has the ability to understand where can device migrate.

So waiting forever can make sure the guest can migrate without caring
about the timeout.

>
> As I explained, there are many RW features in the virtio spec that live m=
igration sw needs to take care to migrate across cross vendor.

Note that those features are virtio features not the transport
specific features. Spec only cares about how to migrate virtio,
instead of migrating transport specific stuff. Another thing is that,
unlike #queue_paris or #msi_vectors, the device rest timeout is not
something that can be provisioned or mediated before/after doing live
migration. Hypervisor may just choose to disable them for the guest
for migration compatibility.

Thanks

> A new RO field that improves the sw stack cannot be attributed as burden =
to live migration sw.

