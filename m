Return-Path: <virtio-dev-return-14226-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472E0C4707B
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 00:26:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8F41B2AF7A
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 00:26:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46FD498646D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 00:26:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 249A1983FDF; Mon, 15 Jan 2024 00:26:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D2C9986367
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Jan 2024 00:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2pEEoEDtN2mQ3rrm0IVe5Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705278369; x=1705883169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/9H6qf/S8HpR/8fGbQcsCsBTLtC18qs4wa+jX39jKA=;
        b=ffKVg9+U9a5cdDm8lqOBu2f/1TKaq4/Zo6tYLM8jtjljQHezg1ECqEWku1Zch1zl6i
         HXBHwabyNkZDYNsnKXgsHPiV3rUfFk9gIxP8oZ2FSJXXa3KJluLjR0eAHtnrLA+JVawK
         g3D25sTKLFGr+a4rMlOewxJb3bhgH6zufnndWGv8GPqdm+gqDOQR6R4VVRKdhlW/YQI1
         opNr0VhSb1KD3N3iNCSpC+I5pkVvjH3zw4yCW5gmTl97QntgeDVh4iFAHMtA2VnOIH1V
         X1tnIpF9J3jtWbyHKQdf2BGrXhBYYPDhpctfphEuLjFMKgniDeVEFZoHZWidfthmbm9X
         LQZw==
X-Gm-Message-State: AOJu0Yxz/Umbc3vbd100dS9v+ijjvY4Ga+Yd8PH1xj7bDRwp2tHgjxzo
	Fw3tNPyXG7VktN88y89LilryPRV15h2HOpReUyLq0LXUCX4XnOCjAniLr/C4aMzo9zw+sBkw/vY
	BNPZpEpPfp1HMIa4IQKYcU00Sk0S9MAZ2nFf2CUPOug0pJ8OG94Db
X-Received: by 2002:a05:6a00:1408:b0:6d9:b9ba:fc7b with SMTP id l8-20020a056a00140800b006d9b9bafc7bmr5702614pfu.33.1705278368988;
        Sun, 14 Jan 2024 16:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJP283mjK9L3cDXjmWonIllry46Q4nlKee4yLf36EdjAnuyZ5iHCw3RvUeOR4OzJUTkbwFLCrqlCTZRGCKwLs=
X-Received: by 2002:a05:6a00:1408:b0:6d9:b9ba:fc7b with SMTP id
 l8-20020a056a00140800b006d9b9bafc7bmr5702592pfu.33.1705278368588; Sun, 14 Jan
 2024 16:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20231021035111.650248-1-Jiqian.Chen@amd.com> <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org> <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 08:25:56 +0800
Message-ID: <CACGkMEu5KV+8V+7x4TC6OQQdJ4FduRrHL9k7qP6VhQi3uTXq1Q@mail.gmail.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
	Robert Beckett <bob.beckett@collabora.com>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>, 
	"Huang, Ray" <Ray.Huang@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature VIRTIO_F_PRESERVE_RESOURCES

On Fri, Jan 12, 2024 at 3:41=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> Hi all,
> Sorry to reply late.
> I don't know if you still remember this problem, let me briefly descript =
it.
> I am working to implement virtgpu S3 function on Xen.
> Currently on Xen, if we start a guest through qemu with enabling virtgpu,=
 and then suspend and resume guest. We can find that the guest kernel comes=
 back, but the display doesn't. It just shown a black screen.
> That is because during suspending, guest called into qemu and qemu destro=
yed all display resources and reset renderer. This made the display gone af=
ter guest resumed.
> So, I add a new command for virtio-gpu that when guest is suspending, it =
will notify qemu and set parameter(preserver_resource) to 1 and then qemu w=
ill preserve resources, and when resuming, guest will notify qemu to set pa=
rameter to 0, and then qemu will keep the normal actions. That can help gue=
st's display come back.
> When I upstream above implementation, Parav and MST suggest me to use the=
 PM capability to fix this problem instead of adding a new command or state=
 bit.
> Now, I have tried the PM capability of virtio-gpu, it can't be used to so=
lve this problem.
> The reason is:
> during guest suspending, it will write D3 state through PM cap, then I ca=
n save the resources of virtio-gpu on Qemu side(set preserver_resource to 1=
),
> but during the process of resuming, the state of PM cap will be cleared b=
y qemu resetting(qemu_system_wakeup-> qemu_devices_reset-> virtio_vga_base_=
reset-> virtio_gpu_gl_reset),
> it causes that when guest reads state from PM cap, it will find the virti=
o-gpu has already been D0 state, so guest will not write D0 through PM cap,=
 so I can't know when to restore the resources(set preserver_resource to 0)=
.

Looks like a bug to be fixed?

> Do you have any other suggestions?
> Or can I just fallback to the version that add a new command(VIRTIO_GPU_C=
MD_PRESERVE_RESOURCE) in virtio-gpu? I think that way is more reasonable an=
d feasible for virtio-gpu to protect display resources during S3. As for ot=
her devices, if necessary, they can also refer to the implementation of the=
 virtio-gpu to add new commands to prevent resource loss during S3.

Note that there's recently a fix for no_soft_reset, a well behaved
device should not suffer from this issue anymore. If I understand this
correctly, there's no need for any extension for the spec as well.:

https://lore.kernel.org/lkml/CACGkMEs_MajTFxGVcK5R8oqQzTxuL4Pm=3DuUnOonDczW=
zqaucsw@mail.gmail.com/T/

Thanks

>
> On 2023/10/27 11:03, Chen, Jiqian wrote:
> > Hi Michael S. Tsirkin and Parav Pandit,
> > Thank you for your detailed explanation. I will try to use PM cap to fi=
x this issue.
> >
> > On 2023/10/26 18:30, Michael S. Tsirkin wrote:
> >> On Thu, Oct 26, 2023 at 10:24:26AM +0000, Chen, Jiqian wrote:
> >>>
> >>> On 2023/10/25 11:51, Parav Pandit wrote:
> >>>>
> >>>>
> >>>>> From: Chen, Jiqian <Jiqian.Chen@amd.com>
> >>>>> Sent: Tuesday, October 24, 2023 5:44 PM
> >>>>>
> >>>>> On 2023/10/24 18:51, Parav Pandit wrote:
> >>>>>>
> >>>>>>> From: Chen, Jiqian <Jiqian.Chen@amd.com>
> >>>>>>> Sent: Tuesday, October 24, 2023 4:06 PM
> >>>>>>>
> >>>>>>> On 2023/10/23 21:35, Parav Pandit wrote:
> >>>>>>>>
> >>>>>>>>> From: Chen, Jiqian <Jiqian.Chen@amd.com>
> >>>>>>>>> Sent: Monday, October 23, 2023 4:09 PM
> >>>>>>>>
> >>>>>>>>>> I think this can be done without introducing the new register.
> >>>>>>>>>> Can you please check if the PM register itself can serve the
> >>>>>>>>>> purpose instead
> >>>>>>>>> of new virtio level register?
> >>>>>>>>> Do you mean the system PM register?
> >>>>>>>> No, the device's PM register at transport level.
> >>>>>>> I tried to find this register(pci level or virtio pci level or vi=
rtio
> >>>>>>> driver level), but I didn't find it in Linux kernel or Qemu codes=
.
> >>>>>>> May I know which register you are referring to specifically? Or w=
hich
> >>>>>>> PM state bit you mentioned below?
> >>>>>>>
> >>>>>> PCI spec's PCI Power Management Capability Structure in section 7.=
5.2.
> >>>>> Yes, what you point to is PM capability for PCIe device.
> >>>>> But the problem is still that in Qemu code, it will check the
> >>>>> condition(pci_bus_is_express or pci_is_express) of all virtio-pci d=
evices in
> >>>>> function virtio_pci_realize(), if the virtio devices aren't a PCIe =
device, it will not
> >>>>> add PM capability for them.
> >>>> PCI PM capability is must for PCIe devices. So may be QEMU code has =
put it only under is_pcie check.
> >>>> But it can be done outside of that check as well because this capabi=
lity exists on PCI too for long time and it is backward compatible.
> >>> Do you suggest me to implement PM capability for virtio devices in
> >>> Qemu firstly, and then to try if the PM capability can work for this
> >>> scenario?
> >>
> >> virtio devices in qemu already have a PM capability.
> >>
> >>
> >>> If so, we will complicate a simple problem. Because there are no othe=
r needs to add PM capability for virtio devices for now, if we add it just =
for preserving resources, it seems unnecessary and unreasonable. And we are=
 not sure if there are other scenarios that are not during the process of P=
M state changing also need to preserve resources, if have, then the PM regi=
ster can't cover, but preserve_resources register can.
> >>
> >> One of the selling points of virtio is precisely reusing existing
> >> platform capabilities as opposed to coming up with our own.
> >> See abstract.tex
> >>
> >>
> >>> Can I add some notes like "If PM capability is implemented for virtio=
 devices, it may cover this scenario, and if there are no other scenarios t=
hat PM can't cover, then we can remove this register " in commit message or=
 spec description and let us continue to add preserve_resources register?
> >>
> >> We can't remove registers.
> >>
> >>>>
> >>>>> And another problem is how about the MMIO transport devices? Since
> >>>>> preserve resources is need for all transport type devices.
> >>>>>
> >>>> MMIO lacks such rich PM definitions. If in future MMIO wants to supp=
ort, it will be extended to match to other transports like PCI.
> >>>>
> >>>>>>>>
> >>>>>>>>> I think it is unreasonable to let virtio- device listen the PM
> >>>>>>>>> state of Guest system.
> >>>>>>>> Guest driver performs any work on the guest systems PM callback
> >>>>>>>> events in
> >>>>>>> the virtio driver.
> >>>>>>> I didn't find any PM state callback in the virtio driver.
> >>>>>>>
> >>>>>> There are virtio_suspend and virtio_resume in case of Linux.
> >>>>> I think what you said virtio_suspend/resume is freeze/restore callb=
ack from
> >>>>> "struct virtio_driver" or suspend/resume callback from "static cons=
t struct
> >>>>> dev_pm_ops virtio_pci_pm_ops".
> >>>>> And yes, I agree, if virtio devices have PM capability, maybe we ca=
n set PM state
> >>>>> in those callback functions.
> >>>>>
> >>>>>>
> >>>>>>>>
> >>>>>>>>> It's more suitable that each device gets notifications from dri=
ver,
> >>>>>>>>> and then do preserving resources operation.
> >>>>>>>> I agree that each device gets the notification from driver.
> >>>>>>>> The question is, should it be virtio driver, or existing pci dri=
ver
> >>>>>>>> which
> >>>>>>> transitions the state from d0->d3 and d3->d0 is enough.
> >>>>>>> It seems there isn't existing pci driver to transitions d0 or d3
> >>>>>>> state. Could you please tell me which one it is specifically? I a=
m very willing to
> >>>>> give a try.
> >>>>>>>
> >>>>>> Virtio-pci modern driver of Linux should be able to.
> >>>>> Yes, I know, it is the VIRTIO_PCI_FLAG_INIT_PM_BIT. But still the t=
wo problems I
> >>>>> said above.
> >>>>>
> >>>> Both can be resolved without switching to pcie.
> >>>>
> >>>>>>
> >>>>>>>> Can you please check that?
> >>>>>>>>
> >>>>>>>>>>> --- a/transport-pci.tex
> >>>>>>>>>>> +++ b/transport-pci.tex
> >>>>>>>>>>> @@ -325,6 +325,7 @@ \subsubsection{Common configuration
> >>>>> structure
> >>>>>>>>>>> layout}\label{sec:Virtio Transport
> >>>>>>>>>>>          /* About the administration virtqueue. */
> >>>>>>>>>>>          le16 admin_queue_index;         /* read-only for dri=
ver */
> >>>>>>>>>>>          le16 admin_queue_num;         /* read-only for drive=
r */
> >>>>>>>>>>> +        le16 preserve_resources;        /* read-write */
> >>>>>>>>>> Preserving these resources in the device implementation takes
> >>>>>>>>>> finite amount
> >>>>>>>>> of time.
> >>>>>>>>>> Possibly more than 40nsec (time of PCIe write TLP).
> >>>>>>>>>> Hence this register must be a polling register to indicate tha=
t
> >>>>>>>>> preservation_done.
> >>>>>>>>>> This will tell the guest when the preservation is done, and wh=
en
> >>>>>>>>>> restoration is
> >>>>>>>>> done, so that it can resume upper layers.
> >>>>>>>>>>
> >>>>>>>>>> Please refer to queue_reset definition to learn more about suc=
h
> >>>>>>>>>> register
> >>>>>>>>> definition.
> >>>>>>>>> Thanks, I will refer to "queue_reset". So, I need three values,
> >>>>>>>>> driver write 1 to let device do preserving resources, driver wr=
ite
> >>>>>>>>> 2 to let device do restoring resources, device write 0 to tell
> >>>>>>>>> driver that preserving or restoring done, am I right?
> >>>>>>>>>
> >>>>>>>> Right.
> >>>>>>>>
> >>>>>>>> And if the existing pcie pm state bits can do, we can leverage t=
hat.
> >>>>>>>> If it cannot be used, lets add that reasoning in the commit log =
to
> >>>>>>>> describe this
> >>>>>>> register.
> >>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Lets please make sure that PCIe PM level registers are
> >>>>>>>>>> sufficient/not-sufficient
> >>>>>>>>> to decide the addition of this register.
> >>>>>>>>> But if the device is not a PCIe device, it doesn't have PM
> >>>>>>>>> capability, then this will not work. Actually in my local
> >>>>>>>>> environment, pci_is_express() return false in Qemu, they are no=
t
> >>>>>>>>> PCIe
> >>>>>>> device.
> >>>>>>>> It is reasonable to ask to plug in as PCIe device in 2023 to get=
 new
> >>>>>>>> functionality that too you mentioned a gpu device. =F0=9F=98=8A
> >>>>>>>> Which does not have very long history of any backward compatibil=
ity.
> >>>>>>> Do you suggest me to add PM capability for virtio-gpu or change
> >>>>>>> virtio-gpu to a PCIe device?
> >>>>>>>
> >>>>>> PCI Power Management Capability Structure does not seem to be limi=
ted to
> >>>>> PCIe.
> >>>>> I am not sure, but in current Qemu code, I can see the check "pci_i=
s_express"
> >>>>> for all virtio-pci devices. If we want to add PM capability for vir=
tio-pci devices,
> >>>>> we need to change them to PCIe device I think.
> >>>>>
> >>>> That is one option.
> >>>> Second option to extend PCI PM cap for non pci device because it is =
supported.
> >>>>
> >>>>>>
> >>>>>
> >>>>> --
> >>>>> Best regards,
> >>>>> Jiqian Chen.
> >>>
> >>> --
> >>> Best regards,
> >>> Jiqian Chen.
> >>
> >
>
> --
> Best regards,
> Jiqian Chen.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

