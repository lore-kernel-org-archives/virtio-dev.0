Return-Path: <mst@redhat.com>
Date: Wed, 27 Oct 2021 04:26:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Message-ID: <20211027040559-mutt-send-email-mst@kernel.org>
References: <CACGkMEs7gAipdbkj4DrpWLsxViHK_qicFVjy6Dy4qP7argih4g@mail.gmail.com>
 <PH0PR12MB548105873DCFFDE8FD95D0A6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEthjkX3pV+1L9Eg-nJOArSUfmDRY8UCK_2LJ7-oxO6SpQ@mail.gmail.com>
 <DM8PR12MB548048016A0311F809BF0E67DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <CACGkMEuP6nZCSyz8piHYdMzwSKGgZbn65SBx486C-Lm2jbw5TA@mail.gmail.com>
 <PH0PR12MB5481C32F9D9A54AFA4E337A3DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2984c445-a7fd-97c4-34aa-3a40778a0fcd@redhat.com>
 <PH0PR12MB54810528108E4EB12CC1C401DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtBJavHQr2SaMiz8TSTt-fCsm3WoJMfRYEO=dr-=Ld-1Q@mail.gmail.com>
 <PH0PR12MB54818FC7BD40A16F656CAE90DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54818FC7BD40A16F656CAE90DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 27, 2021 at 08:04:10AM +0000, Parav Pandit wrote:
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, October 26, 2021 9:34 AM
> > 
> > On Mon, Oct 25, 2021 at 2:11 PM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Monday, October 25, 2021 11:12 AM
> > > [..]
> > > > So what I meant is, if PCI gives us an upper limit of the reset (e.g
> > > > 100ms as you said), can virtio device perform reset more than that?
> > > > If not, can we simply use 100ms for virtio-pci or can we gain from having a
> > smaller per device timeout?
> > > > If yes, it looks like a violation for PCI.
> > > No. Not at all a violation of PCI spec.
> > > PCI spec is transport layer.
> > > Virtio io is layer above transport.
> > >
> > > PCI device can be reset, but not necessary, it is ready to service upper layer
> > protocols who may need more time to finish the reset.
> > 
> > Isn't transport level reset implies a virtio reset? I think this is the question we
> > need to answer or clarify it in the spec. All my suggestions were based on the
> > answer "yes".
> Transport level resets are often too short. It ensures that reset occurred, hence, notifications and DMA activities won't occur after transport reset.
> However, it may not have finished the upper layer reset to re-service the device after transport reset.
> 
> > 
> > Another question is that we don't define reset actually, 
> It has reasonably well definition in the spec in commit: a306bf467850e ("clarify device reset")
> 
> > do we need to do that
> > before trying to define reset timeout? To me the reset means the device can be
> > used by the driver which means all the basic device facilities are ready. 
> Reset is well in spec 1.0 compare to 0.95 indicating that driver need to wait reset to finish.
> 
> i.e. that driver should wait for device status to turn zero during reset and must do reset.
> 
> Unlike 0.95 that explicitly stated " Reset the device. This is not required on initial startup." In section 2.2.1.


Right. So again, I'm trying to help you here. I think the problem with
your approach so far is that it conflates the two things,
physical device startup might take a lot of time and it's
ok since physical host boot takes very long.

This does not seem to be related to a driver init at all
which is what the spec describes.


A reset timeout which can run into seconds will break usecases such as
kata containers. This is why there's so much resistance to adding such a
feature to the spec. reset should be short, in fact it seems reasonable
for spec to give guidance that it should take around ~10ms tops.











> > It
> > means the device is ready from the perspective of a "driver", if the device
> > requires a connection to a remote subsystem, whether or not such connection
> > is established is out of the scope of virtio reset. 
> Sure such implementation detail about remote system connection is outside the scope of spec.
> 
> > Devices can choose not to process the requests from the virtqueue.
> Yes, that is right, but it is not limited to only vq processing.
> As mentioned in the spec section 3.1.1 before VQs are created feature bits, virtio config space values can be read only after reset step_1 is completed.
> 
> > 
> > Another question is that, can we present a PCI device if the underlayer device
> > logic is not ready? 
> Yes, this is very common for hw based devices, unlike synthetic devices for guest VMs.
> This is also discussed in this thread with sriov example.
> 
> > If the question is yes, do we need a new facility to tell the
> > driver that the device is being initialized?
> > 
> May be yes, a different register than the reset can be helpful to indicate that.
> Though it shares lot of functionalities common to the reseting the device.
> 
> Given that this is too early in device initialization sequence,
> Device doesn’t know if should return fake reset_completed status and if driver is going to wait for initializing register or not.
> 
> So let reset register indicate if the reset is completed or not seems more appropriate and less complex solution.

It's not reset though. What is not completed is startup. virtio reset
can't take seconds.

> > >
> > > There are several examples of it in industry today.
> > > nvme, mlx5, efa, intel ice and more who may need more time to reset the
> > upper layer device tan 100msec.
> > 
> > Virtio supports more types than the above list, if it's the timeout that is specific
> > to some types of the devices (e.g block), we need to use device specific
> > methods.
> Block is most common example, but it is not limited to it.
> There are non-synthetic, hw PCI devices of block and non-block types that may need remote connection or may take more time to reset.
> 
> As you described below, traditionally virtio devices were exposed to guest VM by the hypervisor and hence they were always there.
> So resiliency was implicitly present on such guest VM case.
> 
> I gave example of above devices which are used in guest VM devices and as physical devices.
> There isn't the question about widely popular and used virtio devices for guest VM. :-)
> 
> > >
> > > second point that I already explained, is there is nothing wrong at the PCI
> > level that _requires_ further reset.
> > > PCI device is just fine, it is under reset by virtio. Depending on the device
> > implementation it just takes more time.
> > > In few responses in the thread, I already described those different types of
> > devices in response to Cornelia and Michael.
> > > Please go through the thread. Let's not repeat the same discussion again.
> > 
> > So my point is to avoid exposing any implementation specific to the driver. It
> > has a different movitiaton than the discussion you refer to here.
> > 
> There are different type (physical, sriov) and class (net/blk/gpu) of hw PCI devices in addition to sw based devices.
> Single timeout (either infinite or some arbitrary 1 msec) doesn’t fit all class of the devices.
> 
> This proposal provides generic, optional, vendor agnostic, platform agnostic RO register to driver.
> 
> > It's just an example, it could be a hard coded value. If 100ms is not enough we
> > can use something longer.
> 
> It doesn’t make sense to have too short or too high timeout single value by the driver that fits all.
> For example sw synthetic device to guest VM doesn’t need timeout. Guest VM can wait infinitely as device didn't expose the field.
> 
> > > >
> > > > >
> > > > >> It looks to me it will guarantee the success of the reset?
> > > > > You are describing the timeout expiration handling.
> > > >
> > > >
> > > > This looks more important than just having a device hint of the timeout.
> > > > We don't want to block thing like module unload or device removal etc.
> > > >
> > > We already discussed in this thread with Michael, that a device which is
> > already reseted before, a second reset should be fast to service anyway.
> > 
> > Well, this part I don't understand. If you meant the time spent on the "first"
> > reset is implementation dependent but time spent on the "second" reset is fast
> > (not much implementation dependent). It looks like a conclusion that applies
> > only to your specific implementation or hardware.
> 
> No. it is not a specific hw implementation. Usually a firmware/hw based devices takes finite time come up.
> It still have to present the physical PCI device which exists there even before virtio layer shows up for various reasons.
> In such case a first device reset may take longer after power-on.
> 
> A device under control of driver, and running VQs, if being reset is likely to take shorter time.
> This is because it doesn't need to undergo initialization that was already completed on initial first power-on.
> 
> One can still implement to do second reset also as slow as first, but such would be sub-optimal and not useful.
> Not sure, why one would do that.
> 
> > 
> > > Please read the discussion in this thread. Let's not repeat the same discussion
> > again.
> > 
> > It's not a repeat of the discussion, we don't want to end up with a solution that
> > works only for a single vendor or implementation.
> Yes, I don't see any vendor specific implementation pushed here.
> The proposal is making it platform, vendor and device type agnostic and continue to remain optional for sw based devices.
> 
> > 
> > > > >>> Still not any different than rest of the RW capabilities/registers.
> > > > >> So the timeout doesn't work if we can enforce that.
> > > > > Didn’t follow your comment. Enforce what?
> > > >
> > > >
> > > > I meant the timeout value doesn't work here since guest can't see that.
> > > Your example was for VM migration from sw_without_device_reset to
> > hw_with_device_reset.
> > > And here, you wanted to hide the device reset timeout.
> > > So guest _should_not_ be able to see it. Right?
> > 
> > Yes, so if the hardware can work with the infinite waiting in the guest, there's
> > no much value for the device specific reset timeout actually. Isn't it?
> Unlike HV sw exposing device, hw device may experience failures sometimes.
> And a system to recover/resume in finite time from it is useful.

Hmm given software after all runs on the hardware declaring that
it's fundamentally more robust seems controversial ;)

> > > >
> > > Driver can issue transport level reset when reset timeout expires.
> > > First we need the reset timeout to be defined and let it expire. :)
> > > Once it expires, sure, transport level resets can be applied.
> > 
> > Yes, but I'm not sure how device specific timeout can help more:
> > 
> > 1) if device works well, there won't be an infinite wait on the reset
> > 2) if device is buggy,
> > 2.1) wait for ever
> A system might not even boot if it waits for ever just because of single faulty device.
> A user may not even have chance to recover the system/upgrade fw of this faulty device.
> 
> A pre-boot environment using physical device cannot wait forever just because one device in whole system is buggy.
> 
> > 2.2) doing a transport specific reset to prevent data corruption after a timeout
> > 
> > Using 2.2 is tricky since as discussed, the hypervisor may choose to hide this
> > and let guests just use infinite wait for most of the cases.
> > 
> Sure, some hypervisor can hide this for guest VM if it wish to.
> 
> > >
> > > I think you missed this part, that we do not reset to wait infinitely in all places
> > as done today in linux driver.
> > 
> > The reason is that virtio drivers are mostly used in the guest where the device
> > is emulated by the software. It's almost impossible to enforce a timeout for any
> > specific operation, setting device status is just one of the possible operations
> > that may wait forever.
> 
> virtio drivers are having wider uses than just guest env, including preboot, physical devices, sriov etc.
> 
> RO timeout is not about enforcement, it is to set upper bound limit.
> 
> Guest VM that doesn’t follow the spec can do,
> (a) not honor the timeout, and wait forever. 
> (b) ignores the timeout and gets non-operational device.
> 
> And incorrect behavior can happen even with current drivers regardless of the timeout.
> 
> > 
> > > Wait finitely, and when finite time expires, sure, driver can issue transport
> > level reset.
> > 
> > Ok, so I think if we finally go with the way of the device advertised timeout, we
> > need to clarify the transport level reset is a must after timeout in the spec
> > anyhow.
> > 
> I am not sure it is in the scope of the virtio spec.
> I understand it may be good to reset the device, but this is really implementation choice.
> Why cant platform/sw ignore the device with single retry to reset the device without transport level reset?
> I would put that as guidance to driver and not _must_ requirement in the spec.
> 
> Guiding driver to issue transport level reset is very useful to indicate driver that such transport level reset will ensure that notifications and DMA will stop.
> So yes, we should document this instruction for drivers.
> 
> > > This is discussed and Cornelia gave the example also in this thread.
> > > i.e. a fw based hw virtio device may not have finished its initialization in its
> > 100 msec.
> > > so virtio layer may need to wait longer.
> > 
> > Yes, but current code without timeout works in this case.
> It works only if the device didn’t fail to reset.
> 
> > It just to demonstrate possible troubles:
> > 
> > 1) migrate from sw(no timeout) to hw (timeout)
> > 2) migrate from hw(timeout) to sw(no timeout)
> Sw should be enhanced to match the migration from hw.
> 
> > 3) migrate from hw_vendorA(timeoutA) to hw_vendorB(timeoutB)
> Again, this is no different than any other features between two vendors.
> Any emulation, mediation is not A to B migration, it is in between of #2 and #3.
> So perf wise it is still not same.
> 
> > 4) migrate from hw_vendorA(timeoutA_implementationA) to
> > hw_vendorA(timeoutB_implementationB)
> Frankly, this is more practical scenario compare to #3.
> 
> > 5) migrate from hw_vendorA(timeoutA_implementationA) to
> > hw_vendorA(timeoutA_implementationA)
> This doesn’t need any extra care. I think you wanted to say,
> 
> hw_vendorA(timeoutA_implementationA) to hw_vendorA(timeoutA_implementationB)
>                                                                                                                                                     ^^^^^
> > 
> > The hypervisor can only choose to expose timeout value in the case 5) (and it
> > can only do this if it knows all the migration destinations have the same
> > timeout value) and it will let the 1 to 4 to simply use infinite wait by hiding the
> > capability. The management stack should have virtio specific knowledge to
> > poke into the PCIE capabilities list to find and report the timeout and we need
> > cross machine co-ordination with the migration destination or clusters to allow
> > the migration.
> > Hypervisors like Qemu maintain the migration compatibility by using machine
> > type, but this implementation specific attributes makes it almost impossible to
> > be a part of the machine type which means virtio ad-hoc codes were needed.
> 
> With above explanation, I don’t see how QEMU can migrate a virtio device from 4 RSS queues to 2 RSS queues based device with just machine type.
> Does machine type encompass all the device level details too?
> 
> A HV needs to compose (and/or find) the device compatible to the source anyway.
> It is less difficult to find a virtio spec defined device compare to some ad-hoc device.
> 
> > > >
> > > > Similar but one more burden for the management if a simple 100ms
> > > > timeout can work for virtio-pci.
> > > Resilient spec and resilient sw, hw stack is not a burden to management
> > stack.
> > > It is just any other hw/sw attribute of the virtio device to take care.
> > 
> > This is only true if you don't expose any vendor or implementation specific
> > attributes. See above.
> > 
> It is no different than any other virtio features. If source virtio device support of vendor-A supports control VQ,
> And destination virtio device of vendor X (A/B) implementation Y (A/B), doesn't support control VQ,
> They may not be able to migrate.
> 
> HV or other migration sw needs to compatibility check or sometime composing device on destination that matches source attributes.
> 
> It is important to keep LM eyes open, but this is no different than other existing or new virtio features (say statistics of net device in guest vm supported by VF).
> 
> > >
> > > >
> > > > > In another MSI-X example you provided emulated MSIX alterative was
> > > > proposed. This is again not mapping the full hw device.
> > > > >
> > > > > So it is still sw device on other hand. User might as well just
> > > > > continue in sw
> > > > mode.
> > > > >
> > > > > Let's assume for a moment that, this (rare) case should be considered.
> > > > >
> > > > > Once way to overcome this is below.
> > > > > (a) Do not place new device_reset_timeout field in struct
> > > > virtio_pci_common_cfg.
> > > > > This is because this map be in memory mapped BAR directly
> > > > > accessible to the
> > > > guest and future version of the spec has more fields after device reset
> > timeout.
> > > > > Such fields are somehow implemented by the sw device on HV-1.
> > > > >
> > > > > (b) Instead, define new cfg_type VIRTIO_PCI_CAP_DEV_TIMEOUT_CFG.
> > > > > This points to the struct containing device reset timeout.
> > > > > Exposing this capability can be skipped when mapping the hw virtio
> > > > > device to
> > > > VM on HV-2 to match sw virtio device of HV-1.
> > > >
> > > >
> > > > This will ease the hypervisor but anyhow hypervisor can choose to
> > > > not expose the capability directly to guest (which will soon became
> > > > a burden to support cross vendor live migration).
> > > Again it is not a burden.
> > > If a live migration sw needs the ability to migrate between vendors, right
> > approach is to have attributes in the spec.
> > > So that sw has the ability to understand where can device migrate.
> > 
> > So waiting forever can make sure the guest can migrate without caring about
> > the timeout.
> > 
> > >
> > > As I explained, there are many RW features in the virtio spec that live
> > migration sw needs to take care to migrate across cross vendor.
> > 
> > Note that those features are virtio features not the transport specific features.
> > Spec only cares about how to migrate virtio, instead of migrating transport
> > specific stuff. 
> Transport is part of the virtio spec and equally part of the conformance clauses in section 7.
> I don't see how unwritten virtio LM spec won't care about it.
> 
> > Another thing is that, unlike #queue_paris or #msi_vectors, the
> > device rest timeout is not something that can be provisioned or mediated
> > before/after doing live migration. 
> We should work towards it so that if this is really needed, we can mediate it.
> I proposed the option in this thread, that we can do as device reset timeout register via VIRTIO_PCI_CAP_PCI_DEV_TIMEOUT.
> 
> This also enables to not expose in different migration cases you listed above.
> 
> > Hypervisor may just choose to disable them
> > for the guest for migration compatibility.
> > 
> Yes, but this may need disabling many things in a virtio device.
> For any to any migration, a device with lowest common denominator features in the given network will work
> Such device may miss on non-compatible features of the device.
> virtio level control VQ can be one example of it.
> Not sure how one can mediate control VQ while keeping other VQs to device after migration, if it was supported by source device without mediation.
> 
> An LM implementation needs to find/compose destination device either in device or through mediation that match source device.
> Virtio spec addition that makes the mediation easier is a good goal, but not sure all extensions can reach there.
> Some may not, and hence not enhancing the spec for it, doesn’t seem right. Though in case of device reset time, we have alternative proposal to 
> expose via new VIRTIO_PCI_CAP_PCI_DEV_TIMEOUT instead of placement inside struct virtio_pci_common_cfg.


And just to make things clear this is not a reset timeout.
It's a readiness timeout unaffected by reset.

Here's one way I see it working that will likely cause much less
contention than your current proposals:

- new capability that allows reporting device readiness.
  how it looks like, whether there is a timeout is
  a separate question. E.g. a read counter sounds
  more generic, if device is stuck it can just stop
  incrementing it.

- clarify that it's unaffected by virtio reset

- if device is accessed while not ready (e.g. with existing drivers),
  device will not exit reset. For legacy/mmio it will have to block read of
  features until it is ready.


Above is just a vague outlike that should make all this much less
controversial.


-- 
MST

