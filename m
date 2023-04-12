Return-Path: <virtio-dev-return-12192-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E494EC77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:39:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4B83842A6B
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:39:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4247F9865A6
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:39:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 36E24986509; Wed, 12 Apr 2023 05:39:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2626B98650E;
	Wed, 12 Apr 2023 05:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URlDC6CGIcnb1vAgEFLZrG643PNytk3qQeuQGiqNtJ7HXCp1L2vh8nQjIVLUa4i+2QlOwms7K4znR/+g85YXqh5YeZFRTDKG9UfuOaqqzzwH9oj3unYJzRqxNtlRT7bl2wEbTit2XYvlAWQZlLU+ZIrnn5fXLROwmpWECoHzcn3hLBOX0aLwvFrxeK5omOjn1zl4FlE5c7QMyqn/aFWZ5VH9U0Pwusi+eP1esrJbV6p5iOHiIUDzrRDLQ4pTBg2KHSsRKZp2OoSW53Ng4OQkZ/0lYvkeg2zMF5yTWI3jwYW1iI2QEc8GnfQheZLrca0Trzk2QlTjcS9o6it5XGaWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuk7pOud1RrwpzialHWf+uHn68ZrlkA8Mm1N4KgbGjI=;
 b=TnsS4Ycw3/67wJXQ+Z4jbbo/PNala+XOen1qvxvOQ7GCcNGNn0rsAl4QftUF/C84XQ4QnM/b/TXIUjTIhtdQXS2ziZPoJSdrQal8StZi0P7AMiGJ43XgSmbK8ZRND3fnAZHyw1PHdxNxk02teakcT5i8K3dmLwdjOg7XtC7iszPgBMbu3vyAbir0fhHpxgiZWr21CBXCeew02tYb3jfVg91R9IL6VnXgEeYLpQimROtpvXeKWjf89RXWBXDlVVnhHF2PMvaH0ljm8SlTSGBY0jwobkcFSPm2rdMR4/jUoCUFJJiFpOce88Mdt3kWjrknqIPpuC8fHSqMRHD80b3JTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device
Thread-Index:
 AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8nLToAgAAAdXCAAAY+AIAAAFDwgAAC54CAAAKHAA==
Date: Wed, 12 Apr 2023 05:39:14 +0000
Message-ID:
 <PH0PR12MB5481A0456834D196C2F1FCEFDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230412004331-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC4B82A0A57F08ABF3F7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412010437-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481912FE593E532F4566AB8DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412011741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412011741-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5959:EE_
x-ms-office365-filtering-correlation-id: 1a1ceef5-f76c-4094-58e1-08db3b184017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aC79Qan6qdeaH+rKD8AIHqJHsu+do7LnTb4U1wSndk2Y/4q7Q4AIcDVplOi9+zpYg6+7RXaMZRoPHkX5Vi2NcZ7ePLWhf9mIpEEPMU6R/tPT69dh7im+bYqeo0h4bwXI4C4TiXdx5F1C9UqpaQDmGJfh++Q5/9ecLTHsXuLaIm6sHfEYRajKNRDpzOsLM1wU9rnd4yFbgH3ZyYXQlNmTYLMXK+wDH+X5A0KVXr/T1AvkfC3ICgziiTvBh/WIiHgwmGjcLabrAuhN8TbtaeqVe6u7Yy6lyO0hwmXVbyTynZqd7sSJMh2gQb8KgHQbLQE5hDflIwHFLR781RQ+5k5LSD9pRtuWnXlEGREU93LwHcp2PP8jEqG2HvtYwfucFJRLBqGpXRWqqUIL26JAzwdBLVhOXkkmcEW0P6RyUFAY8LRfsfNkUv+O4rYFMcRtPHa0EfgpmE9FdJLg38Osq8K6/+klVBBOhw8n7df8Qt5WmS20i/GrtxzA8IyanaSD9Aylrk8l71YidlynGy+JwbDsZifk9ZHuilUKdamrHrR7J2OWJmVp6dsRyf4NbeKoYCDX1HZgazOggKO7Cz922unQEmYfLFakIeS0OKthJiAwixpFr0VfpJNAnxq5JxpUap8u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(478600001)(7696005)(71200400001)(316002)(186003)(54906003)(66446008)(6506007)(5660300002)(9686003)(4744005)(2906002)(66946007)(66556008)(76116006)(107886003)(41300700001)(8676002)(66476007)(8936002)(6916009)(4326008)(64756008)(38100700002)(33656002)(86362001)(55016003)(122000001)(83380400001)(38070700005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tHj0tXgNleolJHZ9aocGJKBQONx7w4vciQQ3iCBhVCrCyTueVearg3igmjpL?=
 =?us-ascii?Q?SlYF575j2/TjnjnGyXf8oE1Jwxql3LWeL8KNbivYH58U3yjNKm77dzWwpLAd?=
 =?us-ascii?Q?FnSOcFsHxanCNkF4lcu29QogilWn0PBNNWOJyysT2ba1ZDTTAwMvRlTs1/qr?=
 =?us-ascii?Q?Nxdw3eHqm2xmiht4cnjNMxvO9Hw5JBUtiDGTxnWdhTfeuQZag/G9bucc3nD0?=
 =?us-ascii?Q?EIP7BGaawSH7CDKGSngj8vITahjlY85iJZ0NJJJHM500X/Dh30KOQ/5V1p1Q?=
 =?us-ascii?Q?hZqb9Wp5/1OHMI0wEADqBzIDCtKfntu3XcFMNYSt5Zt6IAApcPqmu72HRenE?=
 =?us-ascii?Q?bWzweLFFTeiVyhz/e8qv7Oc/sr6bkIbrlvx7Fn85+B6C7L5CPMQElIjewHAX?=
 =?us-ascii?Q?fwYZa3Lyg9N6Bc2SqfBwxkhHJ6W6aKGyewPmsjYzF9Vp1sFTCqrVoctjHbxq?=
 =?us-ascii?Q?IjvDlK8yvnWzBx2EMicoHGWz4/7tzXjRt5jVsq0DZjbX7qE+GasiUHa8bovN?=
 =?us-ascii?Q?/BxTjDUO8Bl49Ee4P6BGZH75gVlznbGqP3CIBhd2UlThGcUJ5rDCcyEVaiog?=
 =?us-ascii?Q?NmnxmVoDHmHm3xAl8SoW3+ca8ozxOCat7QNMTTQG+D8YFPdlDX8XAdGuieFR?=
 =?us-ascii?Q?/74yvCToUnO1xdYmL6ipbZie+jrS4rNpeZ4ca9rFF6AQ9sLOgGG+HLCDqTyx?=
 =?us-ascii?Q?LWcl6r3ZExwnuXTYkjIgdZGbBMEMUa8WstQy7KpZQVATBQ19rPgrxF0vusss?=
 =?us-ascii?Q?2CehjExHbRGU5ys2hnyR5NnyTPXQl580slkdD61vWTLhYwUUbAoy+5a08huJ?=
 =?us-ascii?Q?xcwADb+/7/fLLhOR5kcjj7TVvzU7WFR34wqPAVKDcCBmv78bKw4drvjCjvxN?=
 =?us-ascii?Q?ftNY8jF+/nMfFxZDCdSPU2qPJMDdOHmWHCwm7z4Dj1gd4T8cK5Jv135o3sfx?=
 =?us-ascii?Q?KmblUwK/Ux4L698j4yhCtBCq94mtpLTJmKZO0SSoHKRnKMs+uAbB26sSo6U0?=
 =?us-ascii?Q?AxaxXr5V/xLESqHUNk0IZWPg29dXPOMMsDs0u0gszbj4rrQF+rcP0FMsLpjd?=
 =?us-ascii?Q?o+yA9VSZIFrXAcbwHFYVTWZtTfOQOo+gH+tXUoZ7ChtvP9lSJ+at2NSCME03?=
 =?us-ascii?Q?kUIlOjUq1frXcL7i3uYskURtcfPnsx1xDnDhm9KFHGQUiRe/JyNf3fMfakTW?=
 =?us-ascii?Q?4CiXZjqG+FCHbwxe0/zZ6OZ99U/VBZGtyomeKb0YuvcATs+wNEdf19KKmN+2?=
 =?us-ascii?Q?4iJxIrMnRFunWdeAMJL9LGKurne1JmfeNSBqe2LXJ25Oyir1aw0bYlY44bZ5?=
 =?us-ascii?Q?N/LwNXV3alw1iG9z8rRmbWTfZXhhQZ3aYS9SiXtYfSIntvL1t5tzsFjjv2jr?=
 =?us-ascii?Q?OB40fIGqxVFXoVz23zxrLadumr3KKSRf27dAbYMQQcYeqsImG4IfctrzKtIx?=
 =?us-ascii?Q?d/KY7sRYe65s9kaFLLubAbAhMMlTydtye7NjyZG1aG4zLxwxzpMWywazN1EH?=
 =?us-ascii?Q?ITQrvB8i2M1Uj0b418EF6ZvlUddjgJTWV+mmgy/Q3bUowBFJtUW4mu5b9uF+?=
 =?us-ascii?Q?5mKUydhqAxAK6565Z5HJX6fw5RYmTGTIH9Ldbouz6Ct1qOjHp7tXScUMXBJF?=
 =?us-ascii?Q?9hLrITUS7JbSZYhHIln6jT4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1ceef5-f76c-4094-58e1-08db3b184017
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:39:14.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmhVLurTWRk0WCGePFbGl0A11+N/7Z9eNUGoz/D+FSjnFq2j9QUAcfynqbnrrC/i+pinumiYJ2AQm7R/Wq10GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 12, 2023 1:24 AM

> You are writing into modern register here. *what* are you writing there?
> with modern register the format depends on features. here you did not
> negotiate any features.=20
Q notify content.

> what if NOTIFICATION_DATA is a required feature?
How can it be required when it is not defined in the legacy spec.

> with legacy there's no FEATURES_OK so no way to report failure.  driver b=
arrels
> on, sends wrong data in the kick and hangs.
>
There is no need for FEATURE_OK because as 1.x configuration registers are =
not touched.

The device provide q notify register region for forwarding.

>=20
> Look I know proposed this originally. I thought it's a small thing too.
> It was an idea. I am not sure it pans out though. Not all ideas work.

This one do work and we have been already testing it.
Described changes with modern devices are simpler than the original proposa=
l indeed.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

