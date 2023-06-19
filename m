Return-Path: <virtio-dev-return-12987-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B56EB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 20:41:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A28BC6109
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 20:41:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1BB569865B8
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 20:41:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0F9D49864BD; Mon, 19 Jun 2023 20:41:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAC8D9863BD;
	Mon, 19 Jun 2023 20:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V488VwQ6/DvTcAP3BudXU027X0INMf/EB8tRLpPLJGdvfvI3sjjYQCeswFqGGL55RyiQsLDASmGTYcfoF94gFCKp/meyLcgJi6YozJHjh237/hs9y4fRA0vxgVRiZ/rdg/s8K1NDoE0DHaDyAUdqZhNtyAShCRBSMhlhUEBADLLaxeTMQTwM2f3VgoN18xxixlmVjcPVQhYDKeKVvRvf8aFWLmXkk4ck8rZO935BKdQMcnD8EHnD1o4mlVbm1nBKjY5yhE2QjB1Ou74QPs1+KD4Yxy7XD5RIsWAq406r2/0/cxk47oeNRsW/t1FoAPgoW9WcJxZmD/5x75lxolThJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a0ljOD4Q17MNfteHNzSu6V1IwiwyaC+Ffi/S43U3L8=;
 b=fiQ3QQyRTIkZXwUeVKG2Gsz1Ea44jmomfAbwlDUg8SAATW6/cAyOPA4xaDYlFA4D+8wMWQJZfiSX+jtxiOHKEunniubTV7D6rQbeefqVXPRcHQuVaDYYYAsS0E3Oe7BnDkA0pQ5qYDYWzyHyPsfYvKzgGGhnlqiAYlgZt7i5B9Vhf2dFlVvJ6P4SRATchswYkFIKCDy2iTUzPCYDgvYKUl76WY1ga7uhKEUuq5ONWVCpq58hnrMx4ztaf17MVq6VgPJnp1U2KGpu4MwHv4kckb/9sby0Q8JEmb4oxxispwMtnaoJ/7BBPtZFJ7yZ1L5kXkl9JSa6xMN+fifjz0lR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: RE: About custom device counter
Thread-Index: AQHZnPYBhAj3P4GR10mqaBAnc/G3uq+Hyx2AgAOiEoCABzS8QA==
Date: Mon, 19 Jun 2023 20:40:54 +0000
Message-ID:
 <PH0PR12MB5481B46BC5108D0BB9D68ED0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B445FDE3A718260C0A0EDC55A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1686810919.3486235-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1686810919.3486235-2-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4041:EE_
x-ms-office365-filtering-correlation-id: c264b6e8-0e89-4787-237e-08db71057aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CIbXys+KslHQERyrAmrJgEHCEgJl+HtBvZVqgrYr+LiGZcEpN3gLcXFikQO6lh8GM/SAyuhgRer3mQIeQsnwk+lKLGjNCWK1CBXUNqURznsYchIe24AUGL658VpUJeE4MRXO2Yw5uR7V4TLxvdqSjnWsFu5ZgLecf4uv2gccAqiV/IGK3uyQrKR29C5cXEp0bs2cB7KHzOET1FWtbAhwG1yKx8ZWL0B04nuqfPmUuw95oOBb5isN76v+iYGwfNN+mmaAqdwRLu/hvgSkWBrHhvvaGdihBBIklE4qugF9vJDcm5pKOAiDeDe88u8eCoFcCYk590rNdRoOJ2MCd0SJDAa1sJ7omvDJ+HRkAq3j8I5j37o46l9BfZbegxsW1GvjiOcdTHTzmWdXNnnLCkChATqG0H8hmiKIn7FF+XjleyCziL7XM+8WjHhIbU8TIi//wE2B+ZBAgsXEdJIyJKCu0zWj5InQTkwidIyVzym5xbndSDlMhXpvqd0KERtyKFITKPlpa+FsRKGxx7FoFwDKs/t2YdVvpliJJfavbwzymyzDbg9LYMqHtURP6/maBBS9ax/U0fPS8B9fbMT9djfK1QGD4LiTSQSo64d4S8pei2tzRojq8qAtM/iUkX4f/ouV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(478600001)(2906002)(54906003)(7696005)(55016003)(86362001)(33656002)(71200400001)(122000001)(38070700005)(52536014)(9686003)(186003)(6506007)(8936002)(8676002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(5660300002)(38100700002)(6916009)(316002)(4326008)(83380400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RJC5QLG+8by9hOjM7PW/hJhc1jz/PnqtPmJwNglyJJ3TLhGbS9NEXKCDWPjv?=
 =?us-ascii?Q?fWE7wh49JGUWVS9SpgLAWshA8vJIMr9pCGTQHXRK0gVBrYM+esvrpaTgfvAf?=
 =?us-ascii?Q?iw4oJ0EY5c94TZq0zZUX+HiNJm+nWSnsRj0yjIxD1RVgKBxx6YX/C0D9/nQE?=
 =?us-ascii?Q?r4rkDMnORepnQX6ZPr6VsxqfQB21kI7+fxF5O1bts9ojWjFhIkBwC7Ba/rGN?=
 =?us-ascii?Q?yOLGTJ4KM5Ec0Je7vFH72wMulLaXz3ELOC+1W8VagL1XC4CZc8l1n75crsfl?=
 =?us-ascii?Q?T+XhfsegIsN3j32hdObV2kLQmXqzHv8gglT4n/zpyhqVe7hQeGedWWbAOJQd?=
 =?us-ascii?Q?SqqtOZ1AyFsZLVJEN403NhwKw2CJstR9SQHwXgq3+pGHAr+oQ08gnr3zCOxR?=
 =?us-ascii?Q?hZjdP1I4nQssfe7s9fCrWw7P/VAtdmVnktDk8SmR3nD6RgWBija/WumTkOTb?=
 =?us-ascii?Q?cWzu6jOxNVio7Rio0qCbwDPzn97SolR/AQloGNb5PZmk8chQsgq6cuJKDBps?=
 =?us-ascii?Q?L5C51dwl56Oyzuw5Ytw8hDSjXjT8k3DPoTm+au0W+JKLMdOf3CZEBdZHwYPw?=
 =?us-ascii?Q?oVE4za5I0iKzBh77lU5SPp1SiGyLOmCzXcyTXhdRpCt8+vDM6UJTvsYZlYwv?=
 =?us-ascii?Q?4cB3MbT0rqwSZPmwQbBM7HLVvCTInKgF1hGC6c4Hu6OwVDjVxd3Nmghhm7SN?=
 =?us-ascii?Q?tIpYzP7TxHMb6D8qftN0MP7PVHNOHREV15VCeiSw0R1eJFWh0rFTIxqDO/rk?=
 =?us-ascii?Q?3jCqymhSj16L5dHhOqMIYj7ZdhS1k5fG0+/DjsQYaCauH+e5/95H1XC86Vmm?=
 =?us-ascii?Q?MjyQGesRWHSQYdl1/aiT+RT3lUsdMQ0dPoC6lLfz0mIyNyNbrZZ25sfpW1WV?=
 =?us-ascii?Q?KMcdpAzL4bII78ryRottebdRacgOcj6NTZpBF/oC0yPVRbt783/glJtpIR0v?=
 =?us-ascii?Q?YfdaPJ3ahtkDWeR2ZwuCqoaHC90p9SSYlqta0Hl3qIjZdaV81/xfl5LCqx6k?=
 =?us-ascii?Q?DxYA2E5Cy+aFIJThpZOUB5359+m29Be5x8gHPlOPsqCnCl3QN2ONCWOKZA8F?=
 =?us-ascii?Q?yD5pQBn+IoIgm0yv5eXUF7wxH6NeAUKgcxlrSrCw1e5H94Jt3ZJys8V0QlZH?=
 =?us-ascii?Q?teL8olrMDam+iPYLSs3JHb8taoV/avIhy6oVmXmWiaLlu/+/UCfoKxzSxWNP?=
 =?us-ascii?Q?eM5Pb5+FbSxxphRbm9T75cETvZptkYkSNFO3DALFTbQLme/VGJWs2Ftlyqmz?=
 =?us-ascii?Q?IFPuiVp9mLkOEQVAn3rKzi3bllRK26BV/SBbipW4vdsHDBGFFtFLcO0R6pSn?=
 =?us-ascii?Q?dzP7Bdz6E+uPU0TISMPbb3V3YIuBpLDL0PFaw2PHay4O+LjKbp15F6ImzVst?=
 =?us-ascii?Q?lisZD85QghZNmrjxHR/HJJQ32Fu0s1mTe6rb3EmPTKa7lBim5ewNtQOrvZy8?=
 =?us-ascii?Q?S09b3c5pXhu90pXbef/2Ort3jPG+welKyo5+WH0II7xVpK+MnZFsXI9sL/vW?=
 =?us-ascii?Q?tss/r3g+4OKd4TgZvRxU5F1EH8/ToZlg7mWGcIxM/8MfZdirBZihX+/+NVhy?=
 =?us-ascii?Q?vLaoqXStSrxj3YXLKFdjE+o8ewn0OQFaaHIMIlG18VwgR2LwZ/HKbWlT5Hml?=
 =?us-ascii?Q?n9EladtGjx3F/HPUfVjA42Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c264b6e8-0e89-4787-237e-08db71057aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 20:40:54.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jb6mBmmFSei+4igaMnYqBr9hjV014aqH6NIX7hE0xOfV1/TT+62Q7jjB+lZl2ro35O1WLlwf9xvWkS3M1rf8WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
Subject: [virtio-dev] RE: RE: About custom device counter



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, June 15, 2023 2:35 AM

> > Debug counters are useful to have.
> > I agree that they may be vendor specific.
> > We often try to abstract and define as much as vendor neutral as possib=
le.
> >
> > So we should probably first put our efforts to see if more than one ven=
dor can
> use it.
>=20
> I agree.
>=20
> >
> > Assuming there is some vendor specific counters, I imagine to come from=
 a
> separate vendor specific query command.
> > This is to keep standard counters to avoid mixing with vend_specific.
>=20
> Yes, I agree that these are two separate channels.
>=20
> But I don't think we need to wait for the first job to finish.
>
I am saying if you have a counter in mind, lets discuss if we can generaliz=
e it, and if we can it falls in the first general bucket.
If we cannot it falls in second vendor specific bucket.
=20
> It is conceivable that standard counters will be displayed on ethtool in =
the
> future. For counters from different manufacturers, we can display them in
> /sys/class/net/eth0/vendor_couters.
>=20
I understood that you want to show device specific counters.
We can avoid bringing up the sw interface for a moment.
For above specific suggestion, vendor counters in sysfs for sure will not b=
e acceptable as no vendor specific sysfs can exist anymore.

One can implement devlink health reporting counters as needed.

> Here we can tell the user that these are only for the current device, and=
 may
> change during the migration process.
>
Sure.
=20
>=20
> >
> > > Of course I know that doing this might hurt migration. But what I
> > > want to say is, why does it affect live migration? These counters we
> > > plan to give to users through ethtool -S, and some changes have
> > > taken place in the ethtool counters output by users. Does this have
> > > any practical impact? Or do we directly use some other output in a
> > > way, we can clearly tell the user that these counters may change
> > > during the migration process. For example, the driver is migrated to
> > > some new devices. These devices support some new counters. I think
> > > users should be able to see these new counters. These new counters ma=
y be
> the purpose of the migration.
> >
> > Counters which are well defined non-vendor specific should be able to
> migrate to destination on best effort basis.
> > For well defined counters if device A at src support N counters, on mig=
rated
> destination, it should be N.
> > This should be able to achieve with feature provisioning infra via grou=
p owner
> command.
>=20
> Yes, for standard counters.
>=20
> >
> > >
> > > We don't need to support live migration at this point.
> > When done on best effort level, infra exists, vendor has ability to
> incrementally implement it.
>=20
>=20
> For the standard counters, the manufacturer will be very willing to use i=
t. I just
> want to introduce the capabilities of the manufacturer's customized.
>=20
Lets try to generalize first and if we fail consider the vendor specific co=
unters.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

