Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Tue, 8 Feb 2022 13:20:15 +0000
Message-ID: <PH0PR12MB5481E32B48021EFF57C02F3CDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <d9c93540-4838-c18e-12c6-9ef4dc0028de@nvidia.com>
 <20220207111649-mutt-send-email-mst@kernel.org>
 <e29a241b-ebd6-ccb5-1f8c-1ca7fad471d9@nvidia.com>
 <20220208014332-mutt-send-email-mst@kernel.org>
 <d4265ec1-8eab-0a53-f2a5-3764d6e2cda5@nvidia.com> <87bkzhv73f.fsf@redhat.com>
In-Reply-To: <87bkzhv73f.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, February 8, 2022 6:39 PM
>=20
> On Tue, Feb 08 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>=20
> > On 2/8/2022 8:45 AM, Michael S. Tsirkin wrote:
> >> On Tue, Feb 08, 2022 at 02:41:44AM +0200, Max Gurtovoy wrote:
> >>> On 2/7/2022 6:18 PM, Michael S. Tsirkin wrote:
> >>>> On Mon, Feb 07, 2022 at 04:58:19PM +0200, Max Gurtovoy wrote:
> >>>>> On 2/7/2022 12:39 PM, Michael S. Tsirkin wrote:
> >>>>>> On Thu, Feb 03, 2022 at 09:57:13AM +0200, Max Gurtovoy wrote:
> >>>>>>> +\begin{lstlisting}
> >>>>>>> +struct virtio_admin_cmd {
> >>>>>>> +        /* Device-readable part */
> >>>>>>> +        u16 command;
> >>>>>>> +        u8 command_specific_data[];
> >>>>>>> +
> >>>>>>> +        /* Device-writable part */
> >>>>>>> +        u8 status;
> >>>>>>> +        u8 command_specific_error;
> >>>>>>> +        u8 command_specific_result[]; }; \end{lstlisting}
> >>>>>> ok this abstraction is an improvement, thanks!
> >>>>>>
> >>>>>> What I'd like to see is moving a bit more format to this generic
> structure.
> >>>>>>
> >>>>>>    From what I could gather, some commands affect a group as a
> >>>>>> whole, and some commands just a single member of the group. We
> >>>>>> could have a "destination" field for that, and a special "all of t=
he group"
> >>>>>> destination for commands affecting the whole group.
> >>>>>>
> >>>>>>
> >>>>>> Next, trying to think about scalable iov extensions. So we will
> >>>>>> have groups of VFs and then SFs as the next level.
> >>>>>> How does one differentiate between the two?
> >>>>>> Maybe reserve a field for "destination type"?
> >>>>> For now we have only a PCI group that composed of VFs and the PF.
> >>>>>
> >>>>> What you suggest, IMO is a definition of a generic virtio
> >>>>> group/subsystem that I've mentioned in the discussion of V1.
> >>>>>
> >>>>> Once we have virtio group - it should have a group id and them the
> >>>>> admin command can have a field calld group_id for commands that
> >>>>> are targeted to the whole group.
> >>>>>
> >>>>> Some commands are referring to a specific device in the group so
> >>>>> only a vdev_id is needed.
> >>>>>
> >>>>> Some commands are even targeted to the same device to query some
> >>>>> info (we have examples in this series for that), so in this case
> >>>>> there is no need for vdev_id nor group_id.
> >>>>>
> >>>>> So I'm sure sure we can improve common virtio_admin_cmd structure
> >>>>> to have these attributes since they are not mandatory because of
> >>>>> the reasons I've mentioned.
> >>>> I'm not sure I understand 100%, but try to address in the next
> >>>> revision and we'll discuss.
> >>> I meant to say that I'm *not* sure we can improve the common structur=
e...
> >>>
> >>> It was a typo.
> >>>
> >>> And I don't understand why this info can't be in the
> >>> command_specific_data because of all the reasons I mentioned above.
> >> It can, but as declared admin commands are there to handle groups of
> >> VFs, so let's standardize how they refer to groups.
> >
> > "Admin virtqueue is one of the management interface that used to send
> > administrative commands to manipulate various features of the *device*
> > and/or to manipulate various features, if possible, of *another device*=
 within
> the same group"
> >
> > It's not only for groups.
>=20
> What I don't understand: Why can't we simply add target information to th=
e
> common definition?=20
A command in the admin queue is always targeted to the device on which AQ r=
esides.
There is no need to add any explicit target field. AQ is just like any othe=
r queue.

A command in the AQ is modifying the attributes of a VF.
If you call this VF as _target_ than related AQ commands already contain th=
e VF id.

> If a certain command doesn't need that target
> information, it is simply ignored.
There is no point in adding any arbitrary and unknown length of reserved by=
tes which are supposed to be ignored.

>=20
> The benefit of reserving a field for target information and specifying ho=
w
> groups and devices are supposed to be addressed is that not every command
> will have to roll their own.
There isn't a good proposal available about how explicit grouping to be don=
e for which some arbitrary group id or target id is requested.
So I think we should not introduce some unknown fields that driver and devi=
ces doesn't know how to use it.

Better to define such new fields when an actual explicit grouping scheme is=
 defined.

